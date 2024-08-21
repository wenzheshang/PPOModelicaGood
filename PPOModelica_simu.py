"""
===================================
Written by Wenzhe Shang @TJU
26/May/2024
===================================
该部分为调用Modelica模型进行模拟的部分
"""
from dymola.dymola_interface import DymolaInterface
from buildingspy.io.outputfile import Reader
from lib.Counter_run_time import CallingCounter
import pandas as pd
import numpy as np
import os
import time

@CallingCounter
def simulate(**kwargs):
    # 读取传入的参数
    k = kwargs
    done = k['stop']
    
    try:
        ResultValue = []
        ResultT = []
        
        problemName = k['problem_name']
        endT = k['endT']
        dir_result = k['dir']
        """
        读入由上级程序传入的模拟句柄
        这样的好处为无需重复打开，造成时间浪费
        """
        dymola = k['core']
            
        #对传入的参数进行数据处理
        value = k['value']

        oac1 = value[0]
        oac2 = value[1]
        oac3 = value[2]
        ocbt = value[3]

        ac1 = np.array([oac1['time'],oac1['ac']]).T
        ac2 = np.array([oac2['time'],oac2['ac']]).T
        ac3 = np.array([oac3['time'],oac3['ac']]).T
        cbt = np.array([ocbt['time'],ocbt['supply']]).T

        slength = ac1.shape[0]+2
        swidth = ac1.shape[1]+1

        length = cbt.shape[0]+2
        #width = cbt.shape[1]+1
        
        #逐个设置表格数据
        name = ['_weisheng','_wujun','_huanchong']
        dymola_setName = ['combiTimeTable'+n+'.table'+str([i,j]) for n in name for i in range(2,slength) for j in range(1,swidth)] 
        dymola_setName.extend(['combiTimeTable.table'+str([i,2]) for i in range(2,length)]) #for j in range(1,width-3)])

        dymola_setValue = [ac1[i][j] for i in range(0,slength-2) for j in range(0,swidth-1)]
        dymola_setValue.extend([ac2[i][j] for i in range(0,slength-2) for j in range(0,swidth-1)])
        dymola_setValue.extend([ac3[i][j] for i in range(0,slength-2) for j in range(0,swidth-1)])
        dymola_setValue.extend([cbt[i][1] for i in range(0,length-2)]) #for j in range(0,width-4)])

        demo_name = 'demo_results'

        result = dymola.simulateExtendedModel(
            problem= problemName,
            startTime=0,
            stopTime=endT,
            numberOfIntervals=0,
            outputInterval=0.0,
            method="Dassl",
            tolerance=0.01,
            fixedstepsize=0.0,
            resultFile=os.path.join(dir_result, demo_name),
            initialNames=dymola_setName,
            initialValues=dymola_setValue,
            autoLoad=True
            )
        #self.multi_result_path_label.setText(demo_name)

    except:
        print('error1')
        log = dymola.getLastError()
        f =  open(os.path.join(k['dir'],'error1.txt'),'w')
        f.write(log)
        f.close()
        return

    try:
        status = result[0]

    except: 
        print('error2')
        log = dymola.getLastError()
        f =  open(os.path.join(k['dir'],'error2.txt'),'w')
        f.write(log)
        f.close()
        return
        
    if not status:
        print('error3')
        log = dymola.getLastError()
        f =  open(os.path.join(k['dir'],'error3.txt'),'w')
        f.write(log)
        f.close()
        return
    else:
        #成功模拟后输出结果部分,加保存excel功能
        #以下代码保存excel文件
        result_path = os.path.join(k['dir'],demo_name+'.mat')
        r = Reader(result_path,'dymola')

        if done:
            result_name = 'reslut'+str(simulate.count)   
            ResultVarName = r.varNames() #获取所有结果变量名
            
            for i in range(len(ResultVarName)):
                (te,r_ser) = r.values(ResultVarName[i])
                ResultValue.append(r_ser[-1])
                ResultT.append(te[-1])
            mydataframe = pd.DataFrame({'Time':ResultT,'VarName':ResultVarName,'Value':ResultValue})
            mydataframe.to_csv(os.path.join(k['dir'], result_name+'.csv'))#将所有结果保存到.csv文件中，以备下次读取

        (t,C1) = r.values('C1')
        (t,C2) = r.values('C2')
        (t,C3) = r.values('C3')
        (t,GRP) = r.values('GasRoom.p')
        (t,GR2P) = r.values('GasRoom1.p')
        (t,GR3P) = r.values('GasRoom2.p')

        lt = list(t)

        if len(ocbt['time']) == 1:

            c1 = C1[254]
            c2 = C2[254]
            c3 = C3[254]
            grp = GRP[254]
            gr2p = GR2P[254]
            gr3p = GR3P[254]  #对第一个特殊处理

            return c1,c2,c3,grp,gr2p,gr3p

        if ocbt['source1'][-2] > 0: #当大于0时选择时段内最大值
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    c1 = max(C1[lt.index(h):lt.index(k)])
                    Grp = []
                    for i in range(len(GRP[lt.index(h):lt.index(k)])):
                        Grp.append(GRP[lt.index(h):lt.index(k)][i]- 100030)
                    grp = max(Grp,key=abs) + 100030
                    break
        else: #否则选择最接近该时刻数据
            print('0')
            c1 = C1[-1]
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    Grp = []
                    for i in range(len(GRP[lt.index(h):lt.index(k)])):
                        Grp.append(GRP[lt.index(h):lt.index(k)][i]- 100030)
                    grp = max(Grp,key=abs) + 100030
                    break
        
        if ocbt['source2'][-2] > 0: #当大于0时选择时段内最大值
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    c2 = max(C2[lt.index(h):lt.index(k)])  
                    Gr2p = []
                    for i in range(len(GR2P[lt.index(h):lt.index(k)])):
                        Gr2p.append(GR2P[lt.index(h):lt.index(k)][i]- 100040)
                    gr2p = max(Gr2p,key=abs) + 100040
                    break
        else: #否则选择最接近该时刻数据
            c2 = C2[-1]
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    Gr2p = []
                    for i in range(len(GR2P[lt.index(h):lt.index(k)])):
                        Gr2p.append(GR2P[lt.index(h):lt.index(k)][i]- 100040)
                    gr2p = max(Gr2p,key=abs) + 100040
                    break

        if ocbt['source3'][-2] > 0: #当大于0时选择时段内最大值
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    c3 = max(C3[lt.index(h):lt.index(k)])  
                    Gr3p = []
                    for i in range(len(GR3P[lt.index(h):lt.index(k)])):
                        Gr3p.append(GR3P[lt.index(h):lt.index(k)][i]- 100035)
                    gr3p = max(Gr3p,key=abs) + 100035
                    break
        else: #否则选择最接近该时刻数据
            c3 = C3[-1]
            for k in t: # 寻找该时刻和前一时刻之内时段的最大值
                if 0 <= k - ocbt['time'][len(ocbt['time'])-2] < 0.0001:
                    h = k
                    continue
                if 0 <= k - ocbt['time'][len(ocbt['time'])-1] < 0.0001:
                    Gr3p = []
                    for i in range(len(GR3P[lt.index(h):lt.index(k)])):
                        Gr3p.append(GR3P[lt.index(h):lt.index(k)][i]- 100035)
                    gr3p = max(Gr3p,key=abs) + 100035
        
        if ((simulate.count / 29) + 1) % 20 == 0:
            dymola.close()
            dymola = None

    return c1,c2,c3,grp,gr2p,gr3p