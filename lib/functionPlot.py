from email.utils import decode_rfc2231
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

matplotlib.rcParams['font.sans-serif'] = 'Times New Roman'

x1 = np.linspace(0, 176, 1000)
c1 = (-(x1-49.77)*(x1-49.77)/(2*46*46))
y1 = np.exp(c1)
x2 = np.linspace(0,1,100)
y2 = (1+np.exp(20*(x2-0.5)))**(-1)
x3 = np.linspace(99965,100105,2000)
y3 = (70-abs(x3-100035))/70

df1 = pd.DataFrame({'x1':x1,'y1':y1})
df2 = pd.DataFrame({'x2':x2,'y2':y2})
df3 = pd.DataFrame({'x3':x3,'y3':y3})
df1.to_csv('F:/Thinking/DR_pro_said/DRL_MO/manuscript/fig/rewardfunction1.csv')
df2.to_csv('F:/Thinking/DR_pro_said/DRL_MO/manuscript/fig/rewardfunction2.csv')
df3.to_csv('F:/Thinking/DR_pro_said/DRL_MO/manuscript/fig/rewardfunction3.csv')

fig,axs = plt.subplots(1,3,figsize=(24,8), gridspec_kw={'width_ratios': [1,1,1]})
ax1 = axs[0]
ax2 = axs[1]
ax3 = axs[2]

ax1.plot(x1,y1,label="Reward function", linewidth = 1.25, color = 'green')
ax1.set_title('(a) Reward function of PM')
ax1.set_xticks([i for i in range(0,181,20)])
ax1.set_xticklabels(['0','20','40','60','80','100','120','140','160','180'])

ax2.plot(x2,y2)
ax2.set_title('(b) Reward function of Energy consume')

ax3.plot(x3,y3)
ax3.set_title('(c) Reward function of Pressure')

plt.savefig('F:/Thinking/DR_pro_said/DRL_MO/manuscript/fig/rewardfunction.svg',dpi=900)

plt.show()