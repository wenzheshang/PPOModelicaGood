import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as mticker
from matplotlib import gridspec
import matplotlib
import os

from sympy import rotations

matplotlib.rcParams['font.family'] = 'sans-serif'  
matplotlib.rcParams['font.sans-serif'] = 'NSimSun,Times New Roman'

file_loc = 'D:/IAQresult/v01/baseline&EGFU1O.xlsx'

baseline = pd.read_excel(file_loc,sheet_name='py_pic')

name_dic = ['action_ave_', 'over15_', 'over35_', 'PM_ave_']
label_dic = ['base','s1','s2','s3']

for i in name_dic:
    for j in label_dic:
        exec(f"{i}{j} = np.array(baseline['{i}{j}'])")

font1 = {'family' : 'Times New Roman',
'weight' : 'normal',
'size'   : 16,
}

fig = plt.figure(figsize=(8,16))
spec = gridspec.GridSpec(ncols=1, nrows=2, height_ratios=[1,1])


#over 15
ax1 = fig.add_subplot(spec[1])

ax1.set_yticks(np.arange(0.1,0.71,0.1))
ax1.set_yticklabels(['10%','20%','30%','40%','50%','60%','70%'],fontsize = 18)
ax1.set_xticks(np.arange(0,41,5))
ax1.set_xticklabels(np.arange(0,41,5),fontsize = 18)
ax1.plot(action_ave_base, over15_base, 'r', marker = "o", 
            label="Baseline control strategy", linewidth = 1.75, color = 'green')

ax1.scatter(action_ave_s3[0], over15_s3[0], label = 'RL control strategy 2', marker='p',
            color = '#FF6600', s = 70)

ax1.plot([action_ave_s3[0],action_ave_s3[0]],[0,over15_s3[0]],ls='--',color = 'red')
ax1.plot([0,action_ave_s3[0]],[over15_s3[0],over15_s3[0]],ls='--',color = 'red')

ax1.plot([action_ave_base[1],action_ave_base[1]],[0,over15_base[1]],ls='--',color = 'green')
ax1.plot([0,action_ave_base[1]],[over15_base[1],over15_base[1]],ls='--',color = 'green')

ax1.legend(loc='upper right',prop = {'size':20})

ax1.set_xlabel('Air cleaner energy consumption monthly(kWh)', fontsize = 20)
ax1.set_ylabel('Indoor PM2.5 concentration over 15 μg/m3 frequency', fontsize = 20)
ax1.set_xlim(-1,41)
ax1.set_ylim(0.12,0.71)
ax1.tick_params(labelsize=20)

#over35
ax3 = fig.add_subplot(spec[0])

ax3.set_xticks(np.arange(0,41,5))
ax3.set_xticklabels(np.arange(0,41,5),fontsize = 18)
ax3.set_yticks(np.arange(0.05,0.26,0.05))
ax3.set_yticklabels(['5%','10%','15%','20%','25%'],fontsize = 18)

ax3.plot(action_ave_base, over35_base, 'r', marker = "o", 
            label='Baseline control strategy', linewidth = 1.75, color = 'red')

ax3.scatter(action_ave_s2[0], over35_s2[0], label = 'RL control strategy 1', marker='D',
            color = 'pink', s = 70)

ax3.scatter(action_ave_s3[0], over35_s3[0], label = 'RL control strategy 2', marker='p',
            color = '#FF6600', s = 70)

ax3.plot([0,action_ave_base[0]],[over35_base[0],over35_base[0]],ls='--',color = 'blue')
ax3.plot([action_ave_s2[0],action_ave_s2[0]],[0,over35_s2[0]],ls='--',color = 'pink')
ax3.plot([action_ave_base[0],action_ave_base[0]],[0,over35_base[0]],ls='--',color = 'blue')

ax3.plot([0,action_ave_base[1]],[over35_base[1],over35_base[1]],ls='--',color = 'green')
ax3.plot([action_ave_s3[0],action_ave_s3[0]],[0,over35_s3[0]],ls='--',color = 'red')
ax3.plot([action_ave_base[1],action_ave_base[1]],[0,over35_base[1]],ls='--',color = 'green')

ax3.legend(loc='upper right',prop = {'size':20})

ax3.set_xlabel('Air cleaner energy consumption monthly(kWh)', fontsize = 20)
ax3.set_ylabel('Indoor PM2.5 concentration over 35 μg/m3 frequency', fontsize = 20)
ax3.set_xlim(-1,41)
ax3.set_ylim(0.04,0.251)
ax3.tick_params(labelsize=20)

ax1.set_title('(b) Compare RL strategy 2 with baseline strategy',fontsize = 22)
ax3.set_title('(a) Compare RL strategy 1 with baseline strategy',fontsize = 22)

plt.subplots_adjust(hspace=0.4, bottom=0.1, left=0.13, right=.9, top = 0.95)

plt.savefig('F:/Thinking/AI/arf/paper/cbto_overMAX_Strategy')
plt.show()


     
