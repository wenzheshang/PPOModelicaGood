#auto_predict3.0
import random 
import pandas as pd
import xlwt
import numpy as np

def random_pick(some_list, probabilities): 
    x = random.uniform(0,1) 
    cumulative_probability = 0.0 
    for item, item_probability in zip(some_list, probabilities): 
        cumulative_probability += item_probability 
        if x < cumulative_probability: 
            break 
    return item 

file_loc='F:\\Thinking\\AI\\arf\\paper_pic\\py_work.xlsx'
datename = '5-10'

#source_predict
situ_list=[0,1]
prob_so = pd.read_excel(file_loc,sheet_name='open&source_fre')

prob_s=list(prob_so['source_frequence'])

workbook_s = xlwt.Workbook('source_predict.xls') # 建立文件
worksheet_s = workbook_s.add_sheet(r'worksheet', cell_overwrite_ok=True) 

for n in range(0,100):
    worksheet_s.write(0,n,n+1)
    for i1 in range(len(prob_s)):
        probabilities = [1-prob_s[i1],prob_s[i1]]
        data=random_pick(situ_list,probabilities)
        worksheet_s.write(i1+1,n,data)
workbook_s.save('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\source_predict.xlsx')

#arf_source_predict
some_list_ca = pd.read_excel(file_loc,sheet_name='closearfwork')
list_ca = list(some_list_ca['数值'])
probabilities_ca = list(some_list_ca['概率'])

some_list_oa = pd.read_excel(file_loc,sheet_name='openarfwork')
list_oa = list(some_list_oa['数值'])
probabilities_oa = list(some_list_oa['概率'])

some_list_cs = pd.read_excel(file_loc,sheet_name='closesourcework')
list_cs = list(some_list_cs['数值'])
probabilities_cs = list(some_list_cs['概率'])

some_list_os = pd.read_excel(file_loc,sheet_name='opensourcework')
list_os = list(some_list_os['数值'])
probabilities_os = list(some_list_os['概率'])

workbook = xlwt.Workbook('predict.xls') # 建立文件
worksheet = workbook.add_sheet(r'worksheet', cell_overwrite_ok=True) 
worksheet1 = workbook.add_sheet(r'worksheet1', cell_overwrite_ok=True) 

some_list = pd.read_excel(file_loc,sheet_name='pre_'+str(datename))
window_list = list(some_list['open'])
    #window_list = list(numpy.array(window_list[str(i)]))
s_l=pd.read_excel('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\source_predict.xlsx')
source_list = np.array(s_l)
    #source_list = list(numpy.array(source_list[str(i)]))

for i in range(0,100):
    worksheet.write(0,i,i+1)
    worksheet1.write(0,i,i+1)

    for k in range(1,49):
        if window_list[k-1] == 1:
            data=random_pick(list_oa,probabilities_oa) 
            worksheet.write(k,i,(data-0.25))
        else:
            data=random_pick(list_ca,probabilities_ca) 
            worksheet.write(k,i,(data-0.025))

    for k in range(1,49):
        if source_list[k-1,i] == 0:
            worksheet1.write(k,i,0)
        else:
            if window_list[k-1] == 0:
                data=random_pick(list_cs,probabilities_cs) 
                worksheet1.write(k,i,(data-2.5))
            else:
                data=random_pick(list_os,probabilities_os) 
                worksheet1.write(k,i,(data-2.5))
                
workbook.save('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\predict_random.xlsx')

############

pm_in=list(some_list['pm_in'])
pm_out=list(some_list['pm_out'])

arf_pre=pd.read_excel('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\predict_random.xlsx',sheet_name='worksheet')
source_pre=pd.read_excel('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\predict_random.xlsx',sheet_name='worksheet1')

arf=np.array(arf_pre)
source=np.array(source_pre)

pm_in_pre=np.zeros((48,100))

for x in range(0,100):
    pm_in_pre[0,x]=pm_in[0]

    for y in range(1,48):

        if window_list[y]==1:
            pm_tem = pm_in_pre[y-1,x]
            for i in range(6):
                pm_in_pre[y,x]=(1/12*arf[y-1,x]*pm_out[y])+(pm_tem*(1-arf[y-1,x]*1/12))+(source[y,x]/6)-((0.22/3)*pm_tem*1/12)
                pm_tem = pm_in_pre[y,x]

        if window_list[y]==2:
            pm_tem = pm_in_pre[y-1,x]
            for i in range(6):
                pm_in_pre[y,x]=(1/12*arf[y-1,x]*pm_out[y])+(pm_tem*(1-arf[y-1,x]*1/12))-10/6-((0.22/3)*pm_tem*1/12)
                pm_tem = pm_in_pre[y,x]

        else:
            pm_tem = pm_in_pre[y-1,x]
            for i in range(6):
                pm_in_pre[y,x]=(1/15*arf[y-1,x]*pm_out[y])+(pm_tem*(1-arf[y-1,x]*1/12))+(source[y,x]/6)-((0.22/3)*pm_tem*1/12)
                pm_tem = pm_in_pre[y,x]

pre_value = xlwt.Workbook('pre.xls') # 建立文件
value = pre_value.add_sheet(r'value', cell_overwrite_ok=True) 

pre_value_average=[]

for bb in range(0,48):
    sum=0
    for aa in range(0,100):
        sum=sum+pm_in_pre[bb,aa]
    average=sum/100
    pre_value_average+=[average]

for ii in range(0,100):
    value.write(0,ii,ii+1)

    for kk in range(1,49):
        value.write(kk,ii,pm_in_pre[kk-1,ii])
        value.write(kk,100,pm_in[kk-1])
        value.write(kk,101,pre_value_average[kk-1])

value.write(0,100,'pm_in')
value.write(0,101,'pm_in_pre')

pre_value.save('F:\\Thinking\\AI\\arf\\paper_pic\\'+str(datename)+'\\randompre_'+str(datename)+'.xlsx')
