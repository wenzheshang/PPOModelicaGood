import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
from mpl_toolkits.axes_grid1 import host_subplot
import mpl_toolkits.axisartist as AA

if __name__ == '__main__':

    version = 'v25'
    version_id = '3P2CZ7'
    epoch = '00071'
    bl_1 = 'Archive result\\Tem_only\\v31\\VHIHQO\\00209\\result-VHIHQO-00209-wholeyear-RL_28.xlsx' 
    rl = 'result-'+version_id+'-'+epoch+'-wholeyear-RL_27.xlsx'
    start_row = [11425]
    root_path = os.path.join('Archive result', 'Tem_only', version, version_id, epoch)
    bl_1_data = pd.read_excel(bl_1)
    # bl_2_data = pd.read_excel(os.path.join(root_path, bl_2))
    rl_data = pd.read_excel(os.path.join(root_path, rl))
    data_list = [bl_1_data, rl_data]
    start_time = 7
    end_time = 19
    font_small = 14
    font_median = 15
    font_title = 16


    for row_i in start_row:
        row_i-=1
        x = np.arange(48)
        win_open_bl_1 = data_list[0]['win_ep_opening'][row_i:row_i+48]
        ia_tem_bl_1 = data_list[0]['ia_db_tem'][row_i:row_i+48]
        oa_tem_bl_1 = data_list[0]['oa_tem'][row_i:row_i+48]
        solar_bl_1 = data_list[0]['solar_radiation_diffuse'][row_i:row_i+48]

 
        
        win_open_rl = data_list[1]['win_ep_opening'][row_i:row_i+48]
        ia_tem_rl = data_list[1]['ia_db_tem'][row_i:row_i+48]
        oa_tem_rl = data_list[1]['oa_tem'][row_i:row_i+48]
        solar_rl = data_list[1]['solar_radiation_diffuse'][row_i:row_i+48]
        sp = list(data_list[1]['set_point'][row_i:row_i+48])

        for i in (np.where(win_open_rl>0)[0]-1):
            sp[i] = 0
        for i in range(14):
            sp[i] = 0
        for i in range(37,48):
            sp[i] = 0

        win_open_bl_1 = list(win_open_bl_1)
        win_open_rl = list(win_open_rl)
        for i in range(48):
            if i <start_time*2 or i>=end_time*2:
                win_open_bl_1[i] = 0
                win_open_rl[i] = 0

        # data_color_normalized = win_open
        # my_cmap = plt.cm.get_cmap('Wistia')
        colors_list = ['#FFBC6B', '#FFBC6B','#F07841','#DB6951','#FA3B2B']
        colors = [colors_list[int(i*4)] for i in win_open_rl]
        os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
        fig, axs = plt.subplots(4, 1, figsize=(12,12), gridspec_kw={'height_ratios': [3,3,1, 1]})
        

        led1 = axs[0].plot(x+0.5,ia_tem_bl_1,'-',label ='RL-1',c = 'blue')
        led3 = axs[0].plot(x+0.5,ia_tem_rl,'-', label ='RL-2',c = 'red')
        led4 = axs[0].bar(x+1.5,sp, fc=(0, 0, 0, 0.3), label ='AC set point for RL-2')
        axs[0].set_xlim([0, 49])
        axs[0].set_xticks(np.arange(0,49,2))
        axs[0].set_xticklabels(['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', 
         '13:00', '14:00','15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'],fontsize=font_median, rotation=45)    
        axs[0].set_ylim([22.8, 30])
        axs[0].set_yticks(np.arange(23,31,2))
        axs[0].set_yticklabels(np.arange(23,31,2),fontsize=font_small)
        axs[0].set_ylabel('Temperature ($^\circ C$)',fontsize=font_small)
        axs[0].legend(loc=3, prop={'size': 10},frameon=False)
        axs[0].set_title('(a) Indoor temperature profile',fontsize=font_title)
        axs[0].plot([0,49],[29.2,29.2],'--', c ='grey')
        # plt.text(36,12.5,'Adaptive comfort upper bound', fontsize = font_small)

        

        axs[1].set_xlim([0, 49])
        led1 = axs[1].plot(x+1,oa_tem_bl_1,'-',label ='Outdoor Temperature', c = (231/255,138/255,195/255))
        axs[1].set_xticks(np.arange(0,49,2))
        axs[1].set_xticklabels(['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', 
         '13:00', '14:00','15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'],fontsize=font_median, rotation=45)    
        axs[1].set_ylim([24, 33])
        axs[1].set_title('(b) Outdoor temperature and solar radiation profile',fontsize=font_title)
        axs[1].set_yticks(np.arange(25,34,2))        
        axs[1].set_yticklabels(np.arange(25,34,2),fontsize=font_small)
        axs[1].set_ylabel('Temperature ($^\circ C$)',fontsize=font_small)
        ax_solar = axs[1].twinx()
        led3 = ax_solar.plot(x+1,solar_bl_1,'-', label = 'Diffuse solar radiation',color= (72/255,120/255,208/255))
        ax_solar.set_ylim([0, 600])
        ax_solar.set_yticks(np.arange(0,601,150))       
        ax_solar.set_yticklabels(np.arange(0,601,150),fontsize=font_small)       
        ax_solar.set_ylabel('Solar radiation ($Wh/m^2$)',fontsize=font_small)

        led = led1 + led3
        led_final = [l.get_label() for l in led] 
        ax_solar.legend(led, led_final, loc=3, prop={'size': 10},frameon=False)


        axs[2].bar(x+0.5,win_open_bl_1,width=1, color = 'blue', edgecolor = 'black')
        axs[2].set_xlim([0, 49])
        axs[2].set_xticks(np.arange(0,49,2))
        axs[2].set_xticklabels(['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', 
         '13:00', '14:00','15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'],fontsize=font_median, rotation=45)    
        axs[2].set_yticks([0, 0.25, 0.5,0.75, 1] )
        axs[2].set_yticklabels(['0%','25%','50%','75%','100%'],fontsize=font_small)
        axs[2].set_title('(c) Window opening for RL-1 control',fontsize=font_title)

        axs[3].bar(x+0.5,win_open_rl,width=1,color = (229/255,196/255,148/255), edgecolor = 'black')
        axs[3].set_xlim([0, 49])
        axs[3].set_xticks(np.arange(0,49,2))
        axs[3].set_xticklabels(['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', 
         '13:00', '14:00','15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00', '24:00'],fontsize=font_median, rotation=45)    
        axs[3].set_yticks([0, 0.25, 0.5,0.75, 1] )
        axs[3].set_yticklabels(['0%','25%','50%','75%','100%'],fontsize=font_small)
        axs[3].set_title('(d) Window opening for RL-2 control',fontsize=font_title)

        # plt.margins(0)
        # plt.show()
        # plt.subplots_adjust(bottom=0.15)
        plt.subplots_adjust(hspace=0.8, bottom=0.1, left=0.08, right=.9, top = 0.95)
        plt.savefig(os.path.join('Output figure', 'output_figure-RL-2-' + version_id  + '-' + str(row_i).zfill(4) + '-PV.jpg'),dpi = 600, format = 'jpg')
        plt.close()                  
    



        co2_bl = np.mean(data_list[0]['indoor_co2'][(row_i+14):(row_i+38)])
        co2_rl = np.mean(data_list[1]['indoor_co2'][(row_i+14):(row_i+38)])

        cooling_bl = np.sum(data_list[0]['total_cooling_rate'][row_i:row_i+48])/2000
        cooling_rl = np.sum(data_list[1]['total_cooling_rate'][row_i:row_i+48])/2000


        fig_1, axs_1 = plt.subplots(1,1,figsize=(6,6*0.8))
        led1 = axs_1.bar(1, co2_bl, 0.3, label = 'RL-1',color= (90/255,169/255,162/255))
        led1 = axs_1.bar(2, co2_rl, 0.3, label = 'RL-2',color= (90/255,169/255,162/255))

        axs_1.set_xlim([0.6,2.5])
        axs_1.set_xticks(np.arange(1,3))
        axs_1.set_xticklabels(['RL-1','RL-2'],fontsize=12)    
        axs_1.set_ylim([0, 1500])
        axs_1.set_yticks(np.arange(0,1500,200))
        axs_1.set_yticklabels(np.arange(0,1500,200),fontsize=12)
        axs_1.set_ylabel('CO$_2$ concentration (ppm)',fontsize=12)
        # axs_1.legend(loc=2, prop={'size': 10},frameon=False)  
        axs_1.set_title('(f) CO$_2$ concentration',fontsize=13)

        plt.subplots_adjust(hspace=0.5, bottom=0.15, left=0.2, right=.95, top = 0.95)
        # plt.show()
        plt.savefig(os.path.join('Output figure', 'output_figure-RL-2-CO2-' + version_id  + '-' + str(row_i).zfill(4) + '-PV.jpg'),dpi = 600, format = 'jpg')

        plt.close()        


        fig_1, axs_1 = plt.subplots(1,1,figsize=(6,6*0.8))
        led1 = axs_1.bar(1, cooling_bl, 0.3, label = 'RL-1', color= (72/255,120/255,208/255))
        led1 = axs_1.bar(2, cooling_rl, 0.3, label = 'RL-2',color= (72/255,120/255,208/255))
        print(cooling_bl)
        print(cooling_rl)
        axs_1.set_xlim([0.6,2.5])
        axs_1.set_xticks(np.arange(1,3))
        axs_1.set_xticklabels(['RL-1','RL-2'],fontsize=12)  
        # print(cooling_bl)  
        axs_1.set_ylim([0, 80])
        axs_1.set_yticks(np.arange(0,80,20))
        axs_1.set_yticklabels(np.arange(0,80,20),fontsize=12)
        axs_1.set_ylabel('Cooling energy (Kwh)',fontsize=12)
        # axs_1.legend(loc=2, prop={'size': 10},frameon=False)  
        axs_1.set_title('(e) Total cooling energy',fontsize=13)

        plt.subplots_adjust(hspace=0.5, bottom=0.15, left=0.15, right=.95, top = 0.95)
        # plt.show()
        plt.savefig(os.path.join('Output figure', 'output_figure-RL-2-Energy-' + version_id  + '-' + str(row_i).zfill(4) + '-PV.jpg'),dpi = 600, format = 'jpg')

        plt.close() 