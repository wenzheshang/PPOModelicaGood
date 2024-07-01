#random_generate
import numpy as np
import random
from openpyxl import Workbook
import xlwt

class generate():
    def __init__(self,windowlist,cycletimes,prob_so,list_ca,probabilities_ca,list_oa,probabilities_oa,list_cs,probabilities_cs,list_os,probabilities_os):
        self.window_list=list(windowlist)
        self.cycle_times = cycletimes
        self.prob_so = prob_so
        self.list_ca = list_ca
        self.probabilities_ca = probabilities_ca
        self.list_oa = list_oa
        self.probabilities_oa = probabilities_oa
        self.list_cs = list_cs
        self.probabilities_cs = probabilities_cs
        self.list_os = list_os
        self.probabilities_os = probabilities_os


    def random_pick(self,some_list, probabilities):
        x = random.uniform(0,1) 
        cumulative_probability = 0.0 
        for item, item_probability in zip(some_list, probabilities): 
            cumulative_probability += item_probability 
            if x < cumulative_probability: 
                break 
        return item 

    def source_predict(self):
        situ_list=[0,1]
        #prob_so = pd.read_excel(self.fileloc,sheet_name='open&source_fre')
        prob_s = self.prob_so
        s_l = np.zeros((self.cycle_times,100))

        for n in range(0,100):
            for k in range(0,28):
                for i1 in range(0,48):
                    probabilities = [1-prob_s[i1],prob_s[i1]]
                    sdatapre = self.random_pick(situ_list,probabilities)
                    s_l[i1*k,n] = sdatapre
        return(s_l)
    

    def arf_source_predict(self):
        #some_list_ca = pd.read_excel(self.fileloc,sheet_name='closearfwork')
        list_ca=self.list_ca
        probabilities_ca=self.probabilities_ca
        list_oa=self.list_oa
        probabilities_oa=self.probabilities_oa
        list_cs=self.list_cs
        probabilities_cs=self.list_cs
        list_os=self.list_os
        probabilities_os=self.probabilities_os

        #workbook = xlwt.Workbook('predict.xls') # 建立文件
        #worksheet = workbook.add_sheet(r'worksheet', cell_overwrite_ok=True) 
        #worksheet1 = workbook.add_sheet(r'worksheet1', cell_overwrite_ok=True) 
        #window_list = list(numpy.array(window_list[str(i)]))

        source_list = self.source_predict()
            #source_list = list(numpy.array(source_list[str(i)]))

        arf_pre = np.zeros((self.cycle_times,100))
        source_pre = np.zeros((self.cycle_times,100))

        Workbook = xlwt.Workbook()
        sheet1 = Workbook.add_sheet('arf')
        sheet2 = Workbook.add_sheet('source')

        for i in range(0,100):

            for k in range(0,self.cycle_times):
                if self.window_list[k] == 1:
                    data1=self.random_pick(list_oa,probabilities_oa) 
                    arf_pre[k,i] = data1-0.25
                else:
                    data1=self.random_pick(list_ca,probabilities_ca) 
                    arf_pre[k,i] = data1-0.025

                sheet1.write(k,i,arf_pre[k,i])

            for k in range(0,self.cycle_times):
                if source_list[k,i] == 0:
                    source_pre[k,i] = 0
                else:
                    if self.window_list[k] == 0:
                        data2=self.random_pick(list_cs,probabilities_cs) 
                        source_pre[k,i] = data2-2.5
                    else:
                        data2=self.random_pick(list_os,probabilities_os) 
                        source_pre[k,i] = data2-2.5   

                sheet2.write(k,i,source_pre[k,i])

        Workbook.save('arf&source_verify3.xls')           
        #workbook.save('C:\\Users\\Administrator\\Desktop\\baseline\\predict_random'+str(time.time())+'.xls')
        #pre_predict_file_loc = 'C:\\Users\\Administrator\\Desktop\\baseline\\predict_random'+str(time.time())+'.xls'


        return arf_pre,source_pre