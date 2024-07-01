"""
===================================
该部分定义了奖励如何进行计算
可根据需要进行更改
===================================
"""
import numpy as np
import pandas as pd
import math

class Reward():
    def __init__(self, w_pm, w_energy, w_dp, result, save_r, save_l):
        self.result_file = result
        self.save = save_r
        self.savel = save_l
        self.w_pm = w_pm
        self.w_enegy = w_energy
        self.w_dp = w_dp

    # def comfort_reward(self, tdb, tr, rh, vr = 0.2, met = 1.1, clo = 0.6):
    #     pmv = pythermalcomfort.models.pmv(tdb, tr, vr, rh, met, clo, standard='ASHRAE')
    #     return 1 - abs(pmv)

    def cal_pm_reward(self, pm):
        #reward = 2-math.exp((pm*pm)/(2*17.19*17.19))  #该部分为另一种reward函数写法，特点为浓度越高下降速度越快，浓度较高时reward为负值

        #reward = math.exp(-(pm*pm)/(75*75))
        
        #reward = -0.5*pm*0.5

        # if pm > 75:
        #     reward = -3
        # if pm > 35:
        #     reward = -math.exp(((pm-35)*(pm-35))/(35*35)) + 1
        # elif pm >15:
        #     reward = math.exp(-((pm-15)*(pm-15))/(15*15))
        # else:
        #     reward = 1
        # 参考文献给出的连续reward函数，特点是在132（限值3/4）处取最大值1，向两侧减少，越接近132，reward增大速度越快
        pm_use = pm/1000
        if pm_use > 176:
            reward = -3.5
        else:
            reward = math.exp(-(pm_use-132)*(pm_use-132)/(54*54))

        # if pm>75:
        #     reward = -100
        # elif pm >30:
        #     reward = -80
        # elif pm >25:
        #     reward = -20
        # elif pm >20:
        #     reward = -10
        # elif pm > 15:
        #     reward = -5
        # else:
        #     reward = 30

        #该部分为分段reward函数

        # 目标：/reward函数连续/尝试一下指数/注意要在合适的时候整体为正值，在不合适的时候给一个负值的reward
        #/最终要求整体PM浓度有一个整体下移，和尽早反馈
        
        return reward

    def cal_dp_reward(self, dp, guideline = 27.5, std = 0.7):
        reward = (30-abs(dp-100030))/30
        #参考文献给出dp奖励函数
        #G1:30,G2:40,G3:35
        return reward
    
    def cal_dp1_reward(self, dp, guideline = 27.5, std = 0.7):
        reward = (30-abs(dp-100040))/30
        #参考文献给出dp奖励函数
        #G1:30,G2:40,G3:35
        return reward

    def cal_dp2_reward(self, dp, guideline = 27.5, std = 0.7):
        reward = (30-abs(dp-100035))/30
        #参考文献给出dp奖励函数
        #G1:30,G2:40,G3:35
        return reward

    def cal_energy_reward(self, action):
        if action < 0.231:
            reward = -1
        if action > 1:
            reward = -1
        else:
            reward = (1+math.exp(20*(action-0.5)))**(-1) #sigmoid函数
        #该部分为参考论文给出的能耗奖励函数
        return reward
    """
    该方法给出了计算总奖励的方案
    总奖励=各个分项奖励*分项权重
    """
    def cal_total_reward(self):
        total_reward = []
  
        pm_ws = self.result_file['pm_weisheng'][0]
        pm_wj = self.result_file['pm_wujun'][0]
        pm_hc = self.result_file['pm_huanchong'][0]
        ac = self.result_file['supply'][0]
        dp_ws = self.result_file['dp_weisheng'][0]
        dp_wj = self.result_file['dp_wujun'][0]
        dp_hc = self.result_file['dp_huanchong'][0]

        pm_reward = self.cal_pm_reward(pm_ws) + self.cal_pm_reward(pm_wj) + self.cal_pm_reward(pm_hc)
        energy_reward = self.cal_energy_reward(ac)     
        dp_reward = self.cal_dp_reward(dp_ws) + self.cal_dp1_reward(dp_wj) + self.cal_dp2_reward(dp_hc)

        total_reward.append(self.w_pm * pm_reward + self.w_enegy * energy_reward + self.w_dp * dp_reward)
        # total_reward.append(self.w_pm * comfort_reward  + self.w_enegy * energy_reward)
        self.result_file['total_reward'] = total_reward
        self.savel.append(total_reward[0])
        self.save['total_reward'] = self.savel
        return self.result_file