#Monte Carol verify
from ctypes.wintypes import SIZE
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.ticker as mticker
import matplotlib
import os

matplotlib.rcParams['font.family'] = 'sans-serif'  
matplotlib.rcParams['font.sans-serif'] = 'NSimSun,Times New Roman'

file_loc = 'F:\\Thinking\\AI\\arf\\paper_pic\\py_pic'

for i in ['2-27','5-10','5-27']:
    file_name = 'randompre_'+i+'.xlsx'
    data_base = pd.read_excel(os.path.join(file_loc,file_name), sheet_name='py_pic')


    time = np.arange(0,24,24/48)
    pm_in = np.array(data_base['pm_in'])
    pm_out = np.array(data_base['pm_out'])
    pm_in_pre = np.array(data_base['pm_in_pre'])

    font1 = {'family' : 'Times New Roman',
    'weight' : 'normal',
    'size'   : 18,
    }

    fig,ax1 = plt.subplots(figsize = (14,6))

    ax1.plot(time, pm_in, 'r',label="Indoor(measured)", linewidth = 1.25, color = 'green')
    ax1.plot(time, pm_in_pre, 'r',label="Indoor(Monte Carlo method)", linewidth = 1.75, color = 'red')
    ax1.plot(time, pm_out, 'r',label="Outdoor(measured)", linewidth = 1.25, color = 'black', ls = '-.')

    ax1.set_xticks([i for i in range(0,25,2)])
    ax1.set_xticklabels([str(i)+':00' for i in range(0,25,2)], rotation=0,fontsize = 18)
    ax1.set_yticks(np.arange(0,max(pm_out)+5,20))
    ax1.set_yticklabels(np.arange(0,max(pm_out)+5,20),fontsize=18)
    ax1.grid(linestyle='--')

    ax1.set_xlabel("Time",font1)
    ax1.set_ylabel('PM2.5 concentration(ug/m3)',font1)
    ax1.legend(loc='upper left',fontsize = 16)
    ax1.set_xlim(-0.5,24.5)

    plt.savefig(os.path.join(file_loc,'randompre_'+i+'.svg'))