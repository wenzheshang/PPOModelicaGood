#frequency
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

file_loc = 'F:\\Thinking\\AI\\arf\\py_work.xlsx'
fre_1h = list(pd.read_excel(file_loc,sheet_name='source_fre_1h')['frequence_1h'])
source_win_open = list(pd.read_excel(file_loc,sheet_name='opensourcework')['概率'])
source_win_close = list(pd.read_excel(file_loc,sheet_name='closesourcework')['概率'])
arf_win_open = list(pd.read_excel(file_loc,sheet_name='openarfwork')['概率'])
arf_win_close = list(pd.read_excel(file_loc,sheet_name='closearfwork')['概率'])
arf = arf_win_close+arf_win_open
x = np.arange(0,24,1)
x1 = np.arange(0,161,5)
x2 = np.arange(0,96,5)
x3 = np.arange(0.5,9.6,0.5)
x4 = np.arange(0,0.46,0.05)

font_tick = 14
font_tick1 = 18
font_label = 20
font_title = 24
font_num = 10
font_legend = 18

fig,axs = plt.subplots(5,1,figsize=(14,40))#gridspec_kw={'height_ratios': [1,1,1,1,1]})
plt.subplots_adjust(left=None, bottom=None, right=None, top=None, wspace=None, hspace=0.3)
plt.style.use('ggplot')

axs[4].set_xticks(np.arange(0,24,1))
axs[4].set_xticklabels(['01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', 
 '13:00', '14:00','15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'], 
  rotation = 30, fontsize = font_tick)
axs[4].set_yticks(np.arange(0,0.09,0.02))
axs[4].set_yticklabels(['0%','2%','4%','6%','8%'],fontsize=font_tick)
axs[4].set_xlim(-0.5,23.5)
axs[4].set_ylim(0,0.09)
axs[4].set_xlabel('time',fontsize = font_label)
axs[4].set_ylabel('possibility',fontsize = font_label)
axs[4].set_title('(e) Frequency histogram of temporal characteristics of the indoor source emission', fontsize = font_title)
axs[4].grid(linestyle = '--',zorder = 0)

led1 = axs[4].bar(x,fre_1h,width = 1, align = 'center', color= (229/255,196/255,148/255),
 edgecolor = 'black', label ='source emission frequence', zorder = 10)
led12 = axs[4].plot(x,fre_1h,color = 'red',zorder = 10)

for a,b,i in zip(x,fre_1h,range(len(x))): # zip 函数
    axs[4].text(a,b+0.005,'%0.2f'%(fre_1h[i]*100)+'%',ha='center',fontsize=font_num,zorder = 15)

axs[4].legend(loc='upper right',prop={'size': font_legend})


axs[3].set_xticks(np.arange(0,166,5))
axs[3].set_xticklabels(np.arange(0,166,5),rotation = 30, fontsize = font_tick1)
axs[3].set_yticks(np.arange(0,0.31,0.05))
axs[3].set_yticklabels(['0%','5%','10%','15%','20%','25%','30%'],fontsize = font_tick1)
axs[3].set_xlim(-0.5,165.5)
axs[3].set_ylim(0,0.31)
axs[3].set_xlabel('source',fontsize = font_label)
axs[3].set_ylabel('possibility',fontsize = font_label)
axs[3].set_title('(d) Frequency histogram of source emission value when window-opening',fontsize = font_title)

led2 = axs[3].bar(x1,source_win_open,width = 5, align = 'edge',edgecolor = 'black',color= (72/255,120/255,208/255),
 label = 'source emission with window opening',zorder = 10)

led22 = axs[3].plot(x1+2.5,source_win_open,color = 'red',zorder = 10)

for a1,b1,i1 in zip(x1,source_win_open,range(len(x1))): # zip 函数
    axs[3].text(a1,b1+0.01,'%0.1f'%(source_win_open[i1]*100)+'%',ha='left',fontsize=font_num,zorder = 15)

axs[3].legend(loc='upper right',prop={'size': font_legend})
axs[3].grid(linestyle = '--',zorder = 0)


axs[2].set_xticks(np.arange(0,101,5))
axs[2].set_xticklabels(np.arange(0,101,5),rotation = 30, fontsize = font_tick1)
axs[2].set_yticks(np.arange(0,0.31,0.05))
axs[2].set_yticklabels(['0%','5%','10%','15%','20%','25%','30%'],fontsize = font_tick1)
axs[2].set_xlim(-0.5,101.5)
axs[2].set_ylim(0,0.31)
axs[2].set_xlabel('source',fontsize = font_label)
axs[2].set_ylabel('possibility',fontsize = font_label)
axs[2].set_title('(c) Frequency histogram of source emission value when window-closing',fontsize = font_title)

led3 = axs[2].bar(x2,source_win_close,width = 5, align = 'edge',edgecolor = 'black',color= (72/255,120/255,208/255),
 label = 'source emission with window closing',zorder=10)

led33 = axs[2].plot(x2+2.5,source_win_close,color = 'red',zorder=10)

for a2,b2,i2 in zip(x2,source_win_close,range(len(x2))): # zip 函数
    axs[2].text(a2,b2+0.01,'%0.1f'%(source_win_close[i2]*100)+'%',ha='left',fontsize=font_num,zorder = 15)

axs[2].legend(loc='upper right',prop={'size': font_legend})
axs[2].grid(linestyle='--',zorder=0)


axs[1].set_xticks(np.arange(0.5,10.1,0.5))
axs[1].set_xticklabels(np.arange(0.5,10.1,0.5),rotation = 30, fontsize = font_tick1)
axs[1].set_yticks(np.arange(0,0.36,0.05))
axs[1].set_yticklabels(['0%','5%','10%','15%','20%','25%','30%','35%'],fontsize = font_tick1)
axs[1].set_xlim(0.4,10.1)
axs[1].set_ylim(0,0.36)
axs[1].set_xlabel('air exchange rate',fontsize = font_label)
axs[1].set_ylabel('possibility',fontsize = font_label)
axs[1].set_title('(b) Frequency histogram of air exchange rate when window-opening',fontsize = font_title)
led4 = axs[1].bar(x3,arf_win_open,width = 0.5, align = 'edge',edgecolor = 'black',color= (90/255,169/255,162/255),
 label = 'air exchange rate with window opening',zorder=10)

led33 = axs[1].plot(x3+0.25,arf_win_open,color = 'red',zorder=10)

for a3,b3,i3 in zip(x3,arf_win_open,range(len(x3))): # zip 函数
    axs[1].text(a3,b3+0.01,'%0.1f'%(arf_win_open[i3]*100)+'%',ha='left',fontsize=font_num,zorder = 15)

axs[1].legend(loc='upper right',prop={'size': font_legend})
axs[1].grid(linestyle='--',zorder=0)


axs[0].set_xticks(np.arange(0,0.51,0.05))
axs[0].set_xticklabels([0.0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5],rotation = 30, fontsize = font_tick1)
axs[0].set_yticks(np.arange(0,0.31,0.05))
axs[0].set_yticklabels(['0%','5%','10%','15%','20%','25%','30%'],fontsize = font_tick1)
axs[0].set_xlim(0,0.51)
axs[0].set_ylim(0,0.31)
axs[0].set_xlabel('air exchange rate',fontsize = font_label)
axs[0].set_ylabel('possibility',fontsize = font_label)
axs[0].set_title('(a) Frequency histogram of air exchange rate when window-closing',fontsize=font_title)
led4 = axs[0].bar(x4,arf_win_close,width = 0.05, align = 'edge',edgecolor = 'black',color= (90/255,169/255,162/255),
 label = 'air exchange rate with window closing',zorder=10)

led44 = axs[0].plot(x4+0.025,arf_win_close,color = 'red',zorder = 10)

for a4,b4,i4 in zip(x4,arf_win_close,range(len(x4))): # zip 函数
    axs[0].text(a4,b4+0.005,'%0.1f'%(arf_win_close[i4]*100)+'%',ha='left',fontsize=font_num,zorder = 15)

axs[0].legend(loc='upper right',prop={'size': font_legend})
axs[0].grid(linestyle='--',zorder=0)

plt.savefig('F:\\Thinking\\AI\\arf\\paper\\arf.svg',dpi=900,format = 'svg')

plt.show()

