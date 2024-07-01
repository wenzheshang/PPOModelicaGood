"""
===================================
Written by Xilei Dai @ NUS
10/Sep/2021
Revised by Wenzhe Shang @TJU
14/May/2024
===================================
该部分代码定义了神经网络训练所使用的环境
调用Modelica模型给出计算结果
进行数据保存和reward计算
"""
import numpy as np
import pandas as pd
from lib.cal_Reward import Reward
from PPOModelica_simu import simulate
# 定义用于训练的环境类
class Game():
    # 对环境进行初始化
    def __init__(self, w_pm,  w_energy, w_dp, source_pre, dir_r):
        self.pm_weisheng = []
        self.pm_wujun = []
        self.pm_huanchong = []
        self.p_weisheng = []
        self.p_wujun = []
        self.p_huanchong = []
        self.ac1_list = []
        self.ac2_list = []
        self.ac3_list = []
        self.supply_list = []
        self.s1_list = []
        self.s2_list = []
        self.s3_list = []
        self.w_pm = w_pm
        self.w_energy = w_energy
        self.w_dp = w_dp
        self.sourcepre = source_pre
        self.dir_result = dir_r
        self.tablesource = {'time':[],'supply':[],'source1':[],'source2':[],'source3':[]}
        self.tableac1 = {'time':[],'ac':[]} #微生物间
        self.tableac2 = {'time':[],'ac':[]} #无菌间
        self.tableac3 = {'time':[],'ac':[]} #缓冲间
        self.reward_list = []      
    """ 
    定义环境运行方式，以及输出
    该方法的输出为：
    next_state：该时间步计算得到的6个状态结果
    reward：根据计算结果得到的奖励
    done：是否完成一次24h的计算标志
    """
    def runEp(self,ac,dymola,count):
        pm1_final = []
        pm2_final = []
        pm3_final = []
        grp_final = [] #微生物间
        gr1p_final = [] #无菌间
        gr2p_final = [] #缓冲间
        ac1_final = []
        ac2_final = []
        ac3_final = []
        supply_final = []
        s1_final = []
        s2_final = []
        s3_final = []
        ac_behavior = ac
        j = count
        if j <= (len(self.sourcepre['Time'])-1):
            # 判断是否达到最后一步，如果达到将done改为True
            done = bool(j >= (len(self.sourcepre['Time'])-1))
            # 神经网络输出ac_behavior在0~1之间，进一步线性调整ac_behavior，将其限制在0.3~0.99之间，保证计算稳定性
            ac_behavior_r = ac_behavior * np.array([0.69,0.69,0.69]) + np.array([0.3,0.3,0.3])
            # 增加总风量，由于总风量由各个分区风量确定，存在限制关系，因此不用神经网络输出，而又各个分区数值计算确定
            ac_behavior_re = np.concatenate((ac_behavior_r, np.array([ac_behavior_r[0]*0.237+ac_behavior_r[1]*0.240+ac_behavior_r[2]*0.293])))
            # 调用Modelica进行计算
            (pm_i1,pm_i2,pm_i3,grp,gr1p,gr2p) = self.cal(ac_behavior_re, self.sourcepre['Time'][j],dymola,done)
            # 保存该时刻计算数据
            pm1_final.append(pm_i1)
            pm2_final.append(pm_i2)
            pm3_final.append(pm_i3)
            grp_final.append(grp)
            gr1p_final.append(gr1p)
            gr2p_final.append(gr2p)
            ac1_final.append(ac_behavior_re[0])
            ac2_final.append(ac_behavior_re[1])
            ac3_final.append(ac_behavior_re[2])
            supply_final.append(ac_behavior_re[3])
            s1_final.append(self.sourcepre['source1'][j])
            s2_final.append(self.sourcepre['source2'][j])
            s3_final.append(self.sourcepre['source3'][j])
            # 最后一个时间步没有下一时刻人员量，因此定义为0
            #if j < (len(self.sourcepre['Time'])-1):
            state = [float((pm_i1-3000)/(176000-3000)), float((pm_i2-3000)/(176000-3000)), float((pm_i3-3000)/(176000-3000)), float(abs((grp-100030)/30)), float(abs((gr1p-100040)/30)), float(abs((gr2p-100035)/30)), self.sourcepre['source1'][j],self.sourcepre['source2'][j],self.sourcepre['source3'][j]]
            # else:
            #     state = [pm_i1/10000,pm_i2/10000,pm_i3/10000,abs(grp-100030),abs(gr1p-100040),abs(gr2p-100035),0,0,0]
            # 将每一步用于计算奖励的数据单独编制为表
            self.reward_result(state, supply_final, grp_final, gr1p_final, gr2p_final)
            # 保存所有时刻的计算数据
            self.pm_weisheng.extend(pm1_final)
            self.pm_wujun.extend(pm2_final)
            self.pm_huanchong.extend(pm3_final)
            self.p_weisheng.extend(grp_final)
            self.p_wujun.extend(gr1p_final)
            self.p_huanchong.extend(gr2p_final)
            self.ac1_list.extend(ac1_final)
            self.ac2_list.extend(ac2_final)
            self.ac3_list.extend(ac3_final)
            self.supply_list.extend(supply_final)
            self.s1_list.extend(s1_final)
            self.s2_list.extend(s2_final)
            self.s3_list.extend(s3_final)
            # 将数据写入保存
            self.summary_result()
            # 计算奖励
            self.cal_reward(self.reward_dataframe,self.my_dataframe,self.reward_list)
            return np.array(state), self.mean_reward, done

        return

    def reward_result(self,state,supply_final, grp_final, gr1p_final, gr2p_final):
        self.reward_dataframe = pd.DataFrame({'pm_weisheng':np.array([state[0]*173000+3000]), 'pm_wujun':np.array([state[1]*173000+3000]), 
                                            'pm_huanchong':np.array([state[2]*173000+3000]), 'dp_weisheng':np.array(grp_final), 
                                            'dp_wujun':np.array(gr1p_final), 'dp_huanchong':np.array(gr2p_final), 
                                            'supply':np.array(supply_final)})
    
    def summary_result(self):
        self.my_dataframe = pd.DataFrame({'pm_weisheng':np.array(self.pm_weisheng), 'pm_wujun':np.array(self.pm_wujun), 
                                            'pm_huanchong':np.array(self.pm_huanchong), 'dp_weisheng':np.array(self.p_weisheng), 
                                            'dp_wujun':np.array(self.p_wujun), 'dp_huanchong':np.array(self.p_huanchong),  
                                            'action1': np.array(self.ac1_list), 'action2':np.array(self.ac2_list),
                                            'action3':np.array(self.ac3_list), 'supply':np.array(self.supply_list),
                                            's1':np.array(self.s1_list),'s2':np.array(self.s2_list),'s3':np.array(self.s3_list)})

    def output_result(self, path = None):
        self.my_dataframe.to_csv(path)

    def cal(self,ac,time,dymola,done):
        ac_1=ac[0]
        ac_2=ac[1]
        ac_3=ac[2]
        supply=ac[3]
        t = time

        self.tablesource['time'].append(t)
        self.tablesource['supply'].append(supply)
        self.tableac1['time'].append(t)
        self.tableac1['ac'].append(ac_1)
        self.tableac2['time'].append(t)
        self.tableac2['ac'].append(ac_2)
        self.tableac3['time'].append(t)
        self.tableac3['ac'].append(ac_3)
        # 调用模型进行模拟
        (PM_C1,PM_C2,PM_C3,P1,P2,P3)  = simulate(core = dymola,
                            #model='F:/Thinking/program/PPOOPT_Modelica/mo/DQLVentilation.mo',
                            problem_name='DQLVentilation.fbs_0513',
                            dir = self.dir_result,
                            endT = t,
                            value = [self.tableac1,self.tableac2,self.tableac3,self.tablesource],
                            stop = done)
        #输入所需数据
        #得出该时刻三个工作区pm浓度
        return PM_C1,PM_C2,PM_C3,P1,P2,P3


    def cal_reward(self,df,dfr,dfl):
        total_reward = Reward(self.w_pm, self.w_energy, self.w_dp, df, dfr, dfl)
        df = total_reward.cal_total_reward()
        self.mean_reward = np.mean(df['total_reward'])

    def normalize_input(self):
        pass