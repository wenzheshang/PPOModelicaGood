"""
===================================
Written by Wenzhe Shang @TJU
26/May/2024
===================================
该部分为PPO训练主程序，运行该部分代码
"""
from numpy.core.numeric import NaN
import argparse
import copy
import pandas as pd
import time
import os
from lib.string_gen import id_generator
import json
from lib.write_result import epoch_result
import pathlib
# import shutil
import numpy as np
import torch
from PPOPlaygame import Game
from lib.Actor import PPO
import random
from dymola.dymola_interface import DymolaInterface

def run(args):
    device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')
    # -------------------------------------- #
    # 环境加载
    # -------------------------------------- #
    # 定义常数
    fail_time = 0
    reward_fail_time = 0
    best_reward = -1000
    # 定义loss记录列表
    acloss_his = []
    crloss_his = []
    # 定义训练结果保存目录
    result_root = 'C:\\Users\\Wenzhe Shang\\Documents\\Result for IAQ'
    if os.path.exists(result_root) == False:
        result_root = 'E:\\ModelicaResult'
    run_id = id_generator()
    run_root = os.path.join(result_root,'v01')
    run_root = os.path.join(run_root,run_id)
    while os.path.exists(run_root):
        run_id = id_generator()
        run_root = os.path.join(result_root,'v01')
        run_root = os.path.join(run_root,run_id)
    os.mkdir(run_root)
    with open(os.path.join(run_root,'commandline_args.txt'), 'w') as f:
        json.dump(args.__dict__, f, indent=2)
        f.close()
    # 定义Modelica模型计算结果保存目录
    now_time = time.strftime('%Y-%m-%d_%H-%M', time.localtime())
    cur_path =  os.path.abspath(os.path.dirname(__file__))
    root_path = cur_path
    dir_result = root_path+"/Workdata/Dymola_python/"+now_time       
    folder = os.path.exists(dir_result)
    if not folder:
        os.makedirs(dir_result)
    # 训练使用的时刻表
    source_pre = pd.read_csv('source.csv')
    
    # -------------------------------------- #
    # 模型构建
    # -------------------------------------- #

    # 神经网络模型实例化
    agent = PPO(n_features=9, n_neuron=128,
          actor_learning_rate=args.actor_lr, critic_learning_rate=args.critic_lr,
          A_UPDATE_STEPS=args.A_up, C_UPDATE_STEPS=args.C_up, epsilon=args.epsilon,max_grad_norm=args.grad_norm)
    
    # -------------------------------------- #
    # 模型训练
    # -------------------------------------- #
    
    return_list = []  # 记录每个回合的return
    mean_return_list = []  # 记录每个回合的return均值
    acloss_epoch = []
    crloss_epcoh = []
    stop = False
    #定位Library位置
    modelicaPath = pathlib.Path(os.environ["DymolaPath"])
    dirBuilding = os.path.join(modelicaPath,"Modelica/Library/Buildings-v7.0.0/Buildings 7.0.0")
    # 构建模拟句柄，用于传递
    dymola = DymolaInterface()
    #打开Library
    dymola.openModel(path=os.path.join(dirBuilding, 'package.mo'))
    dymola.openModel('F:/Thinking/program/PPOOPT_Modelica_good/mo/DQLVentilation.mo')
    
    for i in range(args.epoch):  # 迭代epoch回合
        if (i+1) % 20 == 0:
            # 构建模拟句柄，用于传递
            dymola = DymolaInterface()
            #打开Library
            dymola.openModel(path=os.path.join(dirBuilding, 'package.mo'))
            dymola.openModel('F:/Thinking/program/PPOOPT_Modelica_good/mo/DQLVentilation.mo')
        # 初始化训练环境
        env = Game(args.w_pm,  args.w_energy, args.w_dp, source_pre, dir_result)

        buffer_s, buffer_a, buffer_r = [], [], []
        buffer_log_old = [] # revised by lihan
        buffer_next_state = []
        ep_r = 0 # 每个回合的reward值，是回合每步的reward值的累加

        episode_return = 0  # 累计每条链上的reward
        """ 
        初始化第一个状态
        此步骤主要是由于读取0时刻，Modelica模型计算的数据过大或过小
        为了稳定计算给出初始化状态
        """
        pm_i1 = 3896 #state 1：微生物间PM个数
        pm_i2 = 3896 #state 2：无菌间PM个数
        pm_i3 = 3896 #state 3：缓冲间PM个数
        grp = 100030 #state 4：微生物间压力
        gr1p = 100040 #state 5：无菌间压力
        gr2p = 100035 #state 6：缓冲间压力
        """
        将状态整合成numpy数组形式
        对状态进行线性操作，目的是使输入量级不要差别太大，保证计算稳定性
        state 7：微生物间当前时刻人员量（因为当前时刻人员对下一时刻有影响）
        state 8：无菌间当前时刻人员量
        state 9：缓冲间当前时刻人员量
        """
        state = np.array([float((pm_i1-1000)/(176000-1000)), float((pm_i2-1000)/(176000-1000)), float((pm_i3-1000)/(176000-1000)), 
        float(abs((grp-100030)/30)), float(abs((gr1p-100040)/30)), float(abs((gr2p-100035)/30)),0,0,0])
        done = False  # 环境中回合结束标记

        count = 0 # 记录计算时间步

        while not done:
            # 获取当前状态对应的动作
            action, a_log_prob_old = agent.choose_action(state)
            # 进行一个时刻的计算，得到如下结果：下一时刻状态，奖励，是否完成模拟标志
            next_state, reward, done = env.runEp(action, dymola, count)
            print(count,':','s:',state,'ac:',action,'ns:',next_state,'r:',reward,end = '\n')
            buffer_s.append(state)
            buffer_a.append(action)
            buffer_r.append(reward)  # normalize reward, find to be useful
            buffer_log_old.append(a_log_prob_old)
            buffer_next_state.append(next_state)
            ep_r += reward
            # 状态更新
            state = np.array(next_state)
            # 累计每一步的reward
            episode_return += reward
            # 更新模拟次数
            count = count + 1
            # 如果buffer收集一个batch了或者episode完了，那么update ppo
            if (count+1) % args.BATCH == 0 or done:
                # print('update *****')
                v_s_ = agent.get_v(next_state)
                discounted_r = []
                for r in buffer_r[::-1]:
                    v_s_ = r + args.gamma * v_s_
                    discounted_r.append(v_s_)
                discounted_r.reverse()
                # discounted_r是target_v

                bs, ba = np.vstack(buffer_s), np.vstack(buffer_a)
                br_next_state = np.vstack(buffer_next_state)
                br = np.array(discounted_r)[:, np.newaxis]
                blog_old = np.vstack(buffer_log_old)  # revised by lihan
                # 清空buffer
                buffer_s, buffer_a, buffer_r = [], [], []
                buffer_log_old = []  # revised by lihan
                buffer_next_state = []
                agent.update(bs, ba, br, blog_old, br_next_state)  # 更新PPO

        # 每回合结束进行一次训练      
        #agent.update(transition_dict)
        # 保存每回合数据
        acloss_epoch.append(agent.acloss.detach().numpy())
        crloss_epcoh.append(agent.crloss.detach().numpy())
        # 定义每代训练结果保存位置
        epoch_path = os.path.join(run_root, format(i,'05d'))
        os.mkdir(epoch_path)
        env_epoch = env.my_dataframe
        # 记录reward数据
        return_list.append(episode_return)
        mean_return_list.append(np.mean(return_list[-10:]))  # 平滑
        """
        以下为保存数据以及判断是否应该提前停止训练部分
        主要作用为记录每一代的相关数据，保存每一代训练的神经网络模型
        判断是否长时间reward不再上升，出现输出错误等应该提前终止训练的情况
        """
        if (i % args.save_step == 0):
            try_time = 0
            torch.save(agent.actor.state_dict(),os.path.join(epoch_path,'Actor.pth'))
            torch.save(agent.critic.state_dict(),os.path.join(epoch_path,'Critic.pth'))
            env.output_result(os.path.join(epoch_path,'result.csv'))
            # fail_time = 0
            while try_time<=10:
                try:
                    epoch_result('Tune_summary_new.csv', run_id, i, env_epoch, args)
                    try_time = 0
                    break
                except:
                    print('Please close Tune_summary_new file', flush = True)
                    try_time+=1
                    time.sleep(1)
            if try_time > 10:
                while try_time<20:
                    try:
                        epoch_result('Tune_summary-backup.csv',
                                    run_id, i, env_epoch, args)
                        try_time = 0
                        break
                    except:
                        print('Please close Tune_summary_new file', flush = True)
                        try_time+=1
                        time.sleep(1)
            if try_time>=20:
                stop = True
                reason = 'Fail to write report'
        # 打印回合信息
        print(f'iter:{i}, return:{episode_return}, mean_return:{np.mean(return_list[-10:])}')
        #判断是否停止
        if env.mean_reward > best_reward:
            best_reward = copy.deepcopy(env.mean_reward)
            reward_fail_time = 0
        else:
            reward_fail_time += 1
        
        acloss_avg = round(np.mean(acloss_epoch),5)
        acloss_his.append(acloss_avg)

        crloss_avg = round(np.mean(crloss_epcoh),5)
        crloss_his.append(crloss_avg)

        if acloss_avg is NaN:
            print('==============ACLoss is NAN=================')
            stop = True
            reason = 'NaN'
        if crloss_avg is NaN:
            print('==============CRLoss is NAN=================')
            stop = True
            reason = 'NaN'
        if i == args.epoch - 1:
            stop = True
            reason = 'Achieve epoch'
        with open(os.path.join(run_root, 'loss_log.txt'),'a') as f:
            f.write('acloss:'+str(acloss_his[i]))
            f.write('\n')
            f.write('crloss:'+str(crloss_his[i]))
            f.write('\n')
            f.close()
        if stop:
            with open(os.path.join(run_root,'Stop_reason.txt'),'w') as f:
                f.write(reason)
                f.write('\n')
                f.close()
            with open(os.path.join(pathlib.Path(__file__).parent.resolve(), 'Bad_stop_summary.csv'),'a') as fd:
                fd.write(run_id)
                fd.write(',')
                fd.write(reason)
                fd.write(',')
                fd.write(str(args.epoch))
                fd.write(',')
                fd.write(str(args.BATCH))
                fd.write(',')
                fd.write(str(round(args.actor_lr,5)))
                fd.write(',')
                fd.write(str(round(args.critic_lr,5)))
                fd.write(',')
                fd.write(str(round(args.gamma,5)))
                fd.write(',')
                fd.write(str(round(args.w_pm,5)))
                fd.write(',')
                fd.write(str(round(args.w_energy,5)))
                fd.write(',')
                fd.write(str(round(args.w_dp,5)))
                fd.write(',')
                fd.write(str(args.save_step))
                fd.write(',')
                fd.write(str(args.A_up))
                fd.write(',')
                fd.write(str(args.C_up))
                fd.write(',')
                fd.write(str(round(args.epsilon,5)))
                fd.write(',')
                fd.write(str(round(args.grad_norm,5)))           
                fd.write('\n')
                fd.close()
            break
        
# 以下为主程序，主要定义了各个超参数，以及开始训练的入口
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    # Training config
    parser.add_argument('--epoch', default=1000, type=int)
    parser.add_argument('--BATCH', default=128, type=int)
    parser.add_argument('--actor_lr', default=2e-4, type=float) #actor网络学习率
    parser.add_argument('--critic_lr', default=2e-3, type=float) #critic网络学习率
    parser.add_argument('--gamma', default=0.95, type=float) #奖励因子折扣系数
    parser.add_argument('--w_pm', default=6, type=float) #PM在奖励中的权重
    parser.add_argument('--w_energy', default=8, type=float) #能耗在奖励中的权重
    parser.add_argument('--w_dp', default=1, type=float) #压差在奖励中的权重
    parser.add_argument('--save_step', default=1, type=int)
    parser.add_argument('--A_up', default=10, type=int) #actor网络每次训练次数
    parser.add_argument('--C_up', default=10, type=int) #critic网络每次训练次数
    parser.add_argument('--epsilon', default=0.2, type=float)
    parser.add_argument('--grad_norm', default=0.3, type=float)
    #parser.add_argument('--sigma', default=1, type=int)
    args = parser.parse_args()
    run(args)