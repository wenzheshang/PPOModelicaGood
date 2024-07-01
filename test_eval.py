"""
===================================
Written by Xilei Dai @ NUS
10/Sep/2021
===================================
"""
"""
pm_out.csv和window.csv中的数据来自train_whole30min.xlsx中2017-5月份一整月的数据，
其中16号数据缺失，共30天的数据
"""

from functools import total_ordering
from numpy.core.numeric import NaN
from sklearn import linear_model
from torch._C import device

import torch

from sklearn.preprocessing import MinMaxScaler
import torch.nn as nn
import matplotlib.pyplot as plt
from torch.utils import data
# import tqdm
import argparse
import copy
import pandas as pd
from lib.create_dataset import load_dataset
from lib.Actor import actor
# from PlayGame import Game
from Playgame import Game
import time
import numpy as np
import os
from torch.nn import functional as F
from torch.autograd import Variable
from lib.string_gen import id_generator
import json
from lib.write_result import epoch_result
import pathlib
from lib.random_generate import generate
# import shutil

def run(args):


    fail_time = 0
    reward_fail_time = 0

    result_root = 'C:\\Users\\Xilei Dai\\Documents\\Result for IAQ'
    if os.path.exists(result_root) == False:

        result_root = 'C:\\Users\\xilei\\Documents\\Result for IAQ'

    # write the folder to save model
    if os.path.exists(result_root) == False:
        result_root = 'D:\\IAQresult'

    stop = False
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
    
    # parser = argparse.ArgumentParser()
    # args = parser.parse_args()
    # with open('commandline_args.txt', 'r') as f:
    # args.__dict__ = json.load(f)

    model_behaviror = actor(args.Dropout)
    model_behaviror.load_state_dict(torch.load('D:\\IAQresult\\v01\\LOEB0E_strategy3\\00231\\Actor.pth'))
    model_behaviror.eval()#?
    if args.opt_method == 'SGD':
        optimizer = torch.optim.SGD(model_behaviror.parameters(), lr=args.lr,momentum=args.momentum)
    elif args.opt_method == 'Adam':
        optimizer = torch.optim.Adam(model_behaviror.parameters(), lr=args.lr)

    # print("\nInitializing weights...")
    # for name, param in model_behaviror.named_parameters():
    #     if 'bias' in name:
    #         torch.nn.init.normal_(param,0,0.1)
    #     elif 'weight' in name:
    #         torch.nn.init.normal_(param,0,0.05)

    model_target = copy.deepcopy(model_behaviror)
    scheduler = torch.optim.lr_scheduler.StepLR(optimizer, args.step_size,args.lr_gamma)
    loss_fun = nn.SmoothL1Loss()
    loss_his = []
    model_behaviror.eval()
    model_target.eval()
    best_reward = -100
    os.mkdir(os.path.join(run_root,'EP_file'))

    pm_out = pd.read_csv('pm_out.csv')
    window = pd.read_csv('window.csv')

    fileloc = 'train_whole_data30min_224.xlsx'

    """prob_so = list(pd.read_excel(fileloc,sheet_name='open&source_fre')['source_frequence'])
    list_ca = list(pd.read_excel(fileloc,sheet_name='closearfwork')['数值'])
    probabilities_ca = list(pd.read_excel(fileloc,sheet_name='closearfwork')['概率'])

    list_oa = list(pd.read_excel(fileloc,sheet_name='openarfwork')['数值'])
    probabilities_oa = list(pd.read_excel(fileloc,sheet_name='openarfwork')['概率'])
    
    list_cs = list(pd.read_excel(fileloc,sheet_name='closesourcework')['数值'])
    probabilities_cs = list(pd.read_excel(fileloc,sheet_name='closesourcework')['概率'])
    
    list_os = list(pd.read_excel(fileloc,sheet_name='opensourcework')['数值'])
    probabilities_os = list(pd.read_excel(fileloc,sheet_name='opensourcework')['概率'])

    rg = generate(np.reshape(np.array(window).T,-1),1440,prob_so,list_ca,probabilities_ca,list_oa,probabilities_oa,list_cs,probabilities_cs,list_os,probabilities_os)
    (arf_pre,source_pre)=rg.arf_source_predict()"""
    
    arf_pre = pd.read_csv('arf.csv')
    source_pre = pd.read_csv('source.csv')

    for i in range(args.epoch):   
        ##########  ========= Play Game =================
        # os.mkdir(os.path.join(epoch_path,'EP_file'))
        env = Game(pm_out, window, args.w_pm,  args.w_energy, args.w_noise,arf_pre,source_pre,model_behaviror, args.greedy)
        env.runEp()
        end = time.time()
        env.summary_result()
        # env.simu_pollutant()
        env.cal_reward()
        env.normalize_input()
        # print()
        # env.output_result()
        # env_epoch = pd.read_csv(os.path.join(epoch_path, 'result.csv'))
        env_epoch = env.my_dataframe
        if env.mean_reward > best_reward:
            best_reward = copy.deepcopy(env.mean_reward)
            reward_fail_time = 0
        else:
            reward_fail_time += 1
        
        # For tuning.........
        #if (np.mean(env_epoch['pm_in'] > 5) < 25) & (np.mean(env_epoch['action']) < 0.104):
        if True :
            epoch_path = os.path.join(run_root, format(i,'05d'))
            os.mkdir(epoch_path)            
        # if True:
            if (i % args.save_step == 0):
                try_time = 0
                torch.save(model_behaviror.state_dict(),os.path.join(epoch_path,'Actor.pth'))
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
        else:
            fail_time +=1
        

        train_dataset = load_dataset(env_epoch)
        train_loader = data.DataLoader(train_dataset, batch_size=args.bs, shuffle=True, drop_last=True)                 
        loss_epoch = []
        input_dim = 3
        for replay in range(args.replay_time):
            for batch in train_loader:
                s1 = torch.zeros([args.bs, input_dim])
                s2 = torch.zeros([args.bs, input_dim])
                r = batch[2]
                a = batch[3]
                q = torch.zeros(args.bs)
                for k in range(input_dim):
                    s1[:, k] = batch[0][k]
                    s2[:, k] = batch[1][k]
                q1 = model_behaviror(s1.float())
                for j in range(a.shape[0]):
                    q[j] = q1[j][a[j]]
                with torch.no_grad():
                    q2 = model_target(s2.float())
                    q2 = torch.max(q2, dim = 1)[0]
                    target_q_values = args.q_gamma * q2.float() + r.float()
                # loss = (r.float() + q2.float() - q.float()).unsqueeze(0)
                # loss = ( - ).unsqueeze(0)
                loss = loss_fun(q.type(torch.DoubleTensor), target_q_values.type(torch.DoubleTensor))            
                optimizer.zero_grad()
                # Compute gradients
                loss.mean().backward()
                # torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=2)
                optimizer.step()
                loss_epoch.append(loss.detach().numpy())
                # with open(os.path.join(run_root, 'loss_log_stepwise.txt'),'a') as f:
                #     f.write(str(loss.detach().numpy()))
                #     f.write('\n')
                #     f.close()
        # scheduler.step()
        loss_avg = round(np.mean(loss_epoch),5)
        loss_his.append(loss_avg)
        if loss_avg is NaN:
            print('==============Loss is NAN=================')
            stop = True
            reason = 'NaN'
        if i <= args.tau * 10:
            reward_fail_time = 0
            fail_time = 0
        if fail_time > 30:
            reason = 'No achieved good IAQ'
            stop = True
        if reward_fail_time > 50:
            reason = 'reward not increase'
            stop = True
        with open(os.path.join(run_root, 'loss_log.txt'),'a') as f:
            f.write(str(loss_his[i]))
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
                fd.write(str(round(args.Dropout,2)))
                fd.write(',')
                fd.write(str(round(args.lr_gamma,2)))
                fd.write(',')
                fd.write(str(round(args.lr,5)))
                fd.write(',')
                fd.write(str(round(args.q_gamma,2)))
                fd.write(',')
                fd.write(str(round(args.greedy,2)))
                fd.write(',')
                fd.write(str(args.step_size))
                fd.write(',')
                fd.write(str(args.tau))
                fd.write(',')
                fd.write(str(args.replay_time))
                fd.write(',')
                fd.write(str(round(args.w_comfort,2)))
                fd.write(',')
                fd.write(str(round(args.w_pm,2)))                
                fd.write('\n')
                fd.close()
            break
        if i % args.tau ==0 and i > 0:
            model_target = copy.deepcopy(model_behaviror)
            scheduler.step()

            ### reset optimizer and learning rate
            # if args.opt_method == 'SGD':
            #     optimizer = torch.optim.SGD(model_behaviror.parameters(), lr=args.lr,momentum=args.momentum)
            # elif args.opt_method == 'Adam':
            #     optimizer = torch.optim.Adam(model_behaviror.parameters(), lr=args.lr)
            # scheduler = torch.optim.lr_scheduler.StepLR(optimizer, args.step_size,args.lr_gamma)

        # shutil.rmtree(os.path.join(epoch_path,'EP_file'))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    # Training config
    parser.add_argument('--epoch', default=2000, type=int)
    parser.add_argument('--bs', default=12, type=int)
    parser.add_argument('--lr', default=0.001, type=float)
    parser.add_argument('--momentum', default=0.9, type=float)
    parser.add_argument('--opt_method', default='SGD', type=str)  # SGD, Adam
    parser.add_argument('--Dropout', default=0.0, type=float)
    parser.add_argument('--lr_gamma', default=0.1, type=float)
    parser.add_argument('--q_gamma', default=0.9, type=float)
    parser.add_argument('--greedy', default=0.01, type=float)
    parser.add_argument('--step_size', default=20, type=int)
    parser.add_argument('--tau', default=20, type=int)
    parser.add_argument('--replay_time', default=50, type=int)

    parser.add_argument('--w_comfort', default=3, type=float)
    parser.add_argument('--w_pm', default=0.5, type=float)
    parser.add_argument('--w_energy', default=1, type=float)
    parser.add_argument('--w_noise', default=0.5, type=float)
    parser.add_argument('--save_step', default=1, type=int)
    args = parser.parse_args()
    run(args)