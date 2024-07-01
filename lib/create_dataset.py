import numpy as np
import torch
from torch.utils import data
import pandas as pd
import random
import matplotlib.pyplot as plt
import os


class load_dataset(data.Dataset):
    def __init__(self, env_data, q_length = 10) -> None:
        super().__init__()
        self.env_data = env_data
        self.q_length = q_length
        ## state
        ### ATTENTION !!!!
        ### Need to be consistant with the input variable in PlayGame
        self.s1 = np.array(self.env_data['pm_weisheng'])
        self.s2 = np.array(self.env_data['pm_wujun'])
        self.s3 = np.array(self.env_data['pm_huanchong'])
        self.s4 = np.array(self.env_data['dp_weisheng'])
        self.s5 = np.array(self.env_data['dp_wujun'])
        self.s6 = np.array(self.env_data['dp_huanchong'])
        # self.s1 = np.array(self.env_data['s1'])
        # self.s2 = np.array(self.env_data['s2'])
        # self.s3 = np.array(self.env_data['s3'])

        ## reward
        self.reward_data = np.array(self.env_data['total_reward'])

        ## action
        self.ac1_data = np.array(self.env_data['action1'])
        self.ac2_data = np.array(self.env_data['action2'])
        self.ac3_data = np.array(self.env_data['action3'])
        #self.supply_data = np.array(self.env_data['supply'])

    def __getitem__(self, index):
        # state i
        x1 = self.s1[index]
        x2 = self.s2[index] 
        x3 = self.s3[index]

        x4 = self.s4[index]
        x5 = self.s5[index] 
        x6 = self.s6[index]

        # state i+1
        x1_1 = self.s1[index+1]
        x2_1 = self.s2[index+1]
        x3_1 = self.s3[index+1]

        x4_1 = self.s4[index+1]
        x5_1 = self.s5[index+1]
        x6_1 = self.s6[index+1]

        # reward
        r = self.reward_data[index]

        # action
        ac1 = int(self.ac1_data[index])
        ac2 = int(self.ac2_data[index])
        ac3 = int(self.ac3_data[index])
        #supply = int(self.supply_data[index])
        
        return [x1, x2, x3, x4, x5, x6], [x1_1, x2_1, x3_1, x4_1, x5_1, x6_1], r, [ac1,ac2,ac3]#,supply

    def __len__(self):
        return self.env_data.shape[0] - 1