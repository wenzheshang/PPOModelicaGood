#典型天_v4
from tkinter import font
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import gridspec
from sqlalchemy import true 
from pylab import *
mpl.rcParams['font.sans-serif'] = ['Times New Roman']
import matplotlib

matplotlib.rcParams['font.family'] = 'sans-serif'  
matplotlib.rcParams['font.sans-serif'] = 'NSimSun,Times New Roman'

 
#数据读入
file_loc = 'D:\\IAQresult\\v01\\LOEB0E_strategy3\\00231\\result.xls'
pm_in_opt = list(pd.read_excel(file_loc,sheet_name='work')['pm_in_opt'])
pm_in_base = list(pd.read_excel(file_loc,sheet_name='work')['pm_in_base'])
action_base = list(pd.read_excel(file_loc,sheet_name='work')['action_base'])
action_opt = list(pd.read_excel(file_loc,sheet_name='work')['action_opt'])
pm_out = list(pd.read_excel(file_loc,sheet_name='work')['pm_out'])
window = list(pd.read_excel(file_loc,sheet_name='work')['window'])

#为了显示24个刻度
x=np.arange(0,24,24/48)
x1 = np.arange(-0.5,24.5,24/48)

control_line = 15*np.ones(48)
control_line2 = 35*np.ones(48)


#自定义字体
font_tick = 18
font_legend_medium = 14
font_label = 20
font_title = 24
font_num = 10
font_legend = 18

for i in range(0,30):
    fig,axs = plt.subplots(3,1,figsize=(14,10), gridspec_kw={'height_ratios': [3,1,1]})
    ax1 = axs[0]
    ax2 = axs[1]
    ax3 = axs[2]
    plt.subplots_adjust(hspace=0.8, bottom=0.15, left=0.1, right=0.95, top = 0.95)
    

    ax1.plot(x,pm_in_base[i*48:i*48+48],'r',label="indoor PM2.5 concentration with baseline strategy",color = 'blue')
    ax1.plot(x,pm_in_opt[i*48:i*48+48],'r',label="indoor PM2.5 concentration with RL strategy",color = 'red')
    ax1.plot(x,pm_out[i*48:i*48+48],'r',label="outdoor PM2.5 concentration",color = 'black')
    #自定义横轴 
    ax1.set_xticks([i for i in range(0,25,2)])
    ax1.set_xticklabels(['00:00','02:00','04:00','06:00','08:00','10:00','12:00',
    '14:00','16:00','18:00','20:00','22:00','24:00'], fontsize=font_tick)#fontproperties=myfont
    ax1.set_xlim(-0.5,24.5)
    ax1.set_yticks(np.arange(0,max(pm_out[i*48:i*48+48])+26,25))
    ax1.set_yticklabels(np.arange(0,max(pm_out[i*48:i*48+48])+26,25),fontsize=font_tick)
    ax1.set_ylim(0,max(pm_out[i*48:i*48+48])+26)
    #设置横轴 特定x值时显示刻度
    ax1.plot(x,control_line,color = 'green',ls = '--',label = "PM2.5 control line: 15ug/m3")
    ax1.plot(x,control_line2,color = 'purple',ls = '--',label = "PM2.5 control line: 35ug/m3")
    #显示网格
    ax1.grid(linestyle='--')
    ax1.set_xlabel("Time",fontsize = font_label)
    ax1.set_ylabel('PM2.5 concentration(ug/m3)',fontsize = font_label)
    ax1.legend(loc='best',frameon=False, fontsize = font_legend_medium)
    ax1.set_title('(a)',fontsize = font_title)

    


    for j in range(2,50):
        if window[i*48+j-1]!=window[i*48+j]:
            ax2.plot(x1[j-1:j+1],[window[i*48+j-1],window[i*48+j-1]],'g',color = 'grey')
            ax2.plot([x1[j],x1[j]],window[i*48+j-1:i*48+j+1],'g',color = 'grey')
        if window[i*48+j-1]==window[i*48+j]:
            ax2.plot(x1[j-1:j+1],window[i*48+j-1:i*48+j+1],'g',color = 'grey')
    ax2.plot(x[0],0,'g',color = 'grey',label="Air exchange rate level")
    
    ax2.legend(bbox_to_anchor=(0, -0.5), loc=2, borderaxespad=0,frameon=False,fontsize = font_legend)
    ax2.set_ylabel("Signal",fontsize = font_label)
    ax2.set_xlabel("Time",fontsize = font_label)
    ax2.grid(linestyle='--')
    #限制横轴显示刻度的范围
    ax2.set_xlim(-0.5,24.5)
    ax2.set_xticks([i for i in range(0,25,2)])
    ax2.set_xticklabels(['00:00','02:00','04:00','06:00','08:00','10:00','12:00',
    '14:00','16:00','18:00','20:00','22:00','24:00'], fontsize=font_tick)#fontproperties=myfont
    ax2.set_yticks([0,1/3,2/3,1])
    ax2.set_yticklabels(['0','1/3','2/3','1'],fontsize=font_tick)
    ax2.set_ylim(0,1.1)
    ax2.set_title('(b)',fontsize = font_title)


    for j in range(2,50):
        if action_base[i*48+j-1] != action_base[i*48+j]:
            ax3.plot(x1[j-1:j+1],[action_base[i*48+j-1],action_base[i*48+j-1]],color = 'green')
            ax3.plot([x1[j],x1[j]],action_base[i*48+j-1:i*48+j+1],color = 'green')
        if action_base[i*48+j-1] == action_base[i*48+j]:
            ax3.plot(x1[j-1:j+1],action_base[i*48+j-1:i*48+j+1],color = 'green')
    for j in range(2,50):
        if action_opt[i*48+j-1] != action_opt[i*48+j]:
            ax3.plot(x1[j-1:j+1],[action_opt[i*48+j-1],action_opt[i*48+j-1]],color = 'red')
            ax3.plot([x1[j],x1[j]],action_opt[i*48+j-1:i*48+j+1],color = 'red')
        if action_opt[i*48+j-1] == action_opt[i*48+j]:
            ax3.plot(x1[j-1:j+1],action_opt[i*48+j-1:i*48+j+1],color = 'red')
    
    ax3.plot(x[0],0,'g',color = 'green',label="Air cleaner action with baseline strategy")
    ax3.plot(x[0],0,'g',color = 'red',label="Air cleaner action with RL strategy")
    
    ax3.legend(bbox_to_anchor=(0, -0.5), loc=2, borderaxespad=0,frameon=False,fontsize = font_legend)
    ax3.set_xlabel("Time",fontsize = font_label)
    ax3.set_ylabel("Signal",fontsize = font_label)
    ax3.grid(linestyle='--')
    #限制横轴显示刻度的范围
    ax3.set_xlim(-0.5,24.5)
    ax3.set_xticks([i for i in range(0,25,2)])
    ax3.set_xticklabels(['00:00','02:00','04:00','06:00','08:00','10:00','12:00',
    '14:00','16:00','18:00','20:00','22:00','24:00'], fontsize=font_tick)#fontproperties=myfont
    ax3.set_yticks([0,1/3,2/3,1])
    ax3.set_yticklabels(['0','1/3','2/3','1'],fontsize=font_tick)
    ax3.set_ylim(0,1.1)
    ax3.set_title('(c)',fontsize = font_title)

    
    #plt.show()
    plt.savefig('D:\\IAQresult\\train_LOEB0E_strategy3\\cbto_over15_day'+str(i+1)+'.svg',dpi = 900)

    plt.close()