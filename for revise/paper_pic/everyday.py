#everyday
from email.mime import base
from tkinter import font
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties
from matplotlib import gridspec
from sqlalchemy import true 
from pylab import *
mpl.rcParams['font.sans-serif'] = ['Times New Roman']
import matplotlib
from matplotlib import cm


matplotlib.rcParams['font.family'] = 'sans-serif'  
matplotlib.rcParams['font.sans-serif'] = 'NSimSun,Times New Roman'

file_loc_strategy2 = 'D:\\IAQresult\\v01\\KPL8Z9_strategy2\\KPL8Z9\\00223--important\\result_s2.xls'
file_loc_strategy3 = 'D:\\IAQresult\\v01\\LOEB0E_strategy3\\00231\\result.xls'

pm_in_2 = np.array(pd.read_excel(file_loc_strategy2,sheet_name='work')['pm_in_opt'])
action_2 = np.array(pd.read_excel(file_loc_strategy2,sheet_name='work')['action_opt'])
pm_in_base2 = np.array(pd.read_excel(file_loc_strategy2,sheet_name='work')['pm_in_base'])
action_base2 = np.array(pd.read_excel(file_loc_strategy2,sheet_name='work')['action_base'])

pm_in_3 = np.array(pd.read_excel(file_loc_strategy3,sheet_name='work')['pm_in_opt'])
action_3 = np.array(pd.read_excel(file_loc_strategy3,sheet_name='work1')['action_opt'])
pm_in_base3 = np.array(pd.read_excel(file_loc_strategy3,sheet_name='work')['pm_in_base'])
action_base3 = np.array(pd.read_excel(file_loc_strategy3,sheet_name='work1')['action_base'])

day_30 = np.arange(0,30,1)

s2_over35 = []
s2_energy = []

base2_over35 = []
base2_energy = []

s3_over15 = []
s3_energy = []

base3_over15 = []
base3_energy = []

for i in range(30):

    s2_over35_times=0
    base2_over35_times = 0
    s3_over15_times = 0
    base3_over15_times = 0

    for k in range(48):
        if pm_in_2[i*48+k] > 35:
            s2_over35_times=s2_over35_times+1
        if pm_in_base2[i*48+k] > 35:
            base2_over35_times = base2_over35_times+1 
        if pm_in_3[i*48+k] > 15:
            s3_over15_times=s3_over15_times+1
        if pm_in_base3[i*48+k] > 15:
            base3_over15_times = base3_over15_times+1

    s2_over35.append(s2_over35_times/48)
    base2_over35.append(base2_over35_times/48)
    s3_over15.append(s3_over15_times/48)
    base3_over15.append(base3_over15_times/48)

    s2_action_avg = (np.sum(action_2[i*48:i*48+48]==1/3)/5+np.sum(action_2[i*48:i*48+48]==2/3)/3+np.sum(action_2[i*48:i*48+48]==1))*50*3.6*0.5/3600
    base2_action_avg = (np.sum(action_base2[i*48:i*48+48]==1/3)/5+np.sum(action_base2[i*48:i*48+48]==2/3)/3+np.sum(action_base2[i*48:i*48+48]==1))*50*3.6*0.5/3600
    # s3_action_avg = (np.sum(action_3[i*48:i*48+48]==0.333333333333333)/5+np.sum(action_3[i*48:i*48+48]==0.666666666666666)/3+np.sum(action_3[i*48:i*48+48]==1))*5*3.6*0.5/3600
    # base3_action_avg = (np.sum(action_base3[i*48:i*48+48]==0.333333333333333)/5+np.sum(action_base3[i*48:i*48+48]==0.666666666666666)/3+np.sum(action_base3[i*48:i*48+48]==1))*5*3.6*0.5/3600

    s2_energy.append(s2_action_avg)
    base2_energy.append(base2_action_avg)
    s3_energy.append(action_3[i])
    base3_energy.append(action_base3[i])

s2_max_energy = max([max(s2_energy),max(base2_energy)])
s3_max_energy = max([max(s3_energy),max(base3_energy)])

s2_min_energy = min([min(s2_energy),min(base2_energy)])
s3_min_energy = min([min(s3_energy),min(base3_energy)])

color_s2 = []
color_s3 = []
color_b2 = []
color_b3 = []

for i in range(30):
    mcolor_s2 = (s2_energy[i]-s2_min_energy)/(s2_max_energy-s2_min_energy)
    mcolor_b2 = (base2_energy[i]-s2_min_energy)/(s2_max_energy-s2_min_energy)
    mcolor_s3 = (s3_energy[i]-s3_min_energy)/(s3_max_energy-s3_min_energy)
    mcolor_b3 = (base3_energy[i]-s3_min_energy)/(s3_max_energy-s3_min_energy)

    color_s2.append(mcolor_s2)
    color_s3.append(mcolor_s3)
    color_b2.append(mcolor_b2)
    color_b3.append(mcolor_b3)

fig,axs = plt.subplots(1,1,figsize = (36, 9))#,gridspec_kw={'height_ratios': [1,1]})
map_vir = cm.get_cmap(name='Reds')
font_tick = 16
font_tick_L = 24
font_legend = 24
font = FontProperties(fname=r"c:\windows\fonts\simsun.ttc", size=24)


# axs[0].set_xticks(np.arange(0,30,1))
# axs[0].set_xticklabels(['day '+str(i) for i in range(1,31,1)],rotation = 30, fontsize = font_tick)
# axs[0].set_xlim(-1,30)
# axs[0].set_yticks(np.arange(0,0.26,0.05))
# axs[0].set_yticklabels(['0%','5%','10%','15%','20%','25%'],fontsize = font_tick_L)
# axs[0].set_ylim(0,0.25)

colorb2 = map_vir(color_b2)
colors2 = map_vir(color_s2)
norm_s2 = plt.Normalize(s2_min_energy,s2_max_energy)

# axs[0].bar(day_30-0.4,base2_over35,width = 0.4, align = 'edge',
#     edgecolor = 'black', color = colorb2)
# axs[0].bar(day_30, s2_over35, width = 0.4, align = 'edge',
#     edgecolor = 'black', color = colors2)

# axs[0].bar(0,0, color = 'white', label = '左侧柱：基准控制策略结果')#Left bar: results of baseline control strategy
# axs[0].bar(0,0, color = 'white', label = '右侧柱：强化学习策略1结果')#'Right bar: results of RL-1 strategy')

# sm = cm.ScalarMappable(norm=norm_s2,cmap=map_vir)
# plt.sca(axs[0])
# cb = plt.colorbar(sm)
# cb.ax.tick_params(labelsize = font_tick)
# cb.set_label('Energy consumption(kWh)', fontsize = font_tick)
# axs[0].legend(loc = 'upper right',frameon=False,fontsize = font_legend)
# axs[0].set_ylabel('PM2.5 over 35 frequency',fontsize = font_label)


axs.set_xticks(np.arange(0,30,1))
axs.set_xticklabels(['Day '+str(i) for i in range(1,31,1)], fontsize = font_tick)
axs.set_xlim(-1,30)
axs.set_yticks(np.arange(0,0.91,0.1))
axs.set_yticklabels(['0%','10%','20%','30%','40%','50%','60%','70%','80%','90%'],fontsize = font_tick_L)
axs.set_ylim(0,0.91)

colorb3 = map_vir(color_b3)
colors3 = map_vir(color_s3)
norm_s3 = plt.Normalize(s3_min_energy,s3_max_energy)

axs.bar(day_30-0.3,base3_over15,width = 0.3, align = 'edge', 
    edgecolor = 'black', color = colorb3)
axs.bar(day_30, s3_over15, width = 0.3, align = 'edge', 
    edgecolor = 'black', color = colors3)

label1 = axs.bar(0,0, color = 'white', label = '左侧柱：基准控制策略下空气净化器控制效果')#'Left bar: results of baseline control strategy')
label2 = axs.bar(0,0, color = 'white', label = '右侧柱：强化学习策略下空气净化器控制效果')#'Right bar: results of RL-2 control strategy')


sm = cm.ScalarMappable(norm=norm_s3,cmap=map_vir)
plt.sca(axs)
cb = plt.colorbar(sm)
cb.ax.tick_params(labelsize = font_tick)
cb.set_label('能耗(kWh)', fontproperties = font)

plt.rcParams['font.family']=['SimHei']
plt.legend(loc = 'upper right', fontsize = 20, frameon =False)

axs.set_ylabel('PM2.5 浓度超过15的频率',fontproperties = font)

plt.subplots_adjust(hspace=0.3, bottom=0.05, left=None, right=None, top = None)

plt.savefig('F:\\Thinking\\AI\\arf\\paper\\30day_changebaseline_Chinese.svg', dpi = 900, format = 'svg')


plt.show()