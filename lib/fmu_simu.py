import pandas as pd
import numpy as np
import shutil
from fmpy import *
from fmpy import read_model_description, extract
from fmpy.fmi2 import FMU2Slave
from lib.Counter_run_time import CallingCounter

@CallingCounter
def floFmu(**kwargs):
    count = floFmu.count
    """input a 7*1 list"""
    inputList = kwargs['inputValue']

    dirLocation = kwargs['dir']

    fmu_file = 'fmu/easykjz_flow_bala(fmu_0326_ductchange)(FMU).fmu'
    # simulate_fmu(fmu_file)
    model_description = read_model_description(fmu_file)

    unzipdir = extract(fmu_file)
    vrs = {}
    for variable in model_description.modelVariables:
            vrs[variable.name] = variable.valueReference

    vr_inputs = [vrs['[DiamLeft1]'],vrs['[DiamLeft2]'],vrs['[DiamLeft3]'],vrs['[DiamRight1]'],vrs['[DiamRight2]'],vrs['[DiamRight3]'],vrs['[DiamRight4]']]#[vrs['[DiamLeft]'],vrs['[DiamMiddel]'],vrs['[DiamRight]']]
    vr_outputsFlow = [vrs['MassFlow1'],vrs['MassFlow2'],vrs['MassFlow3'],vrs['MassFlowA'],vrs['MassFlowB'],vrs['MassFlowC'],
                        vrs['MassFlow5'], vrs['MassFlow6'],vrs['MassFlowD'],vrs['MassFlowE'],vrs['MassFlow4'],vrs['MassFlowF']]
    # vr_outputs123ABC = [vrs['MassFlow1'],vrs['MassFlow2'],vrs['MassFlow3'],vrs['MassFlowA'],vrs['MassFlowB'],vrs['MassFlowC']]#[vrs['MassFlow1'],vrs['MassFlow2'],vrs['MassFlow3']]
    # vr_outputs56DE = [vrs['MassFlow5'],vrs['MassFlow6'],vrs['MassFlowD'],vrs['MassFlowE']]#[vrs['MassFlowA'],vrs['MassFlowB'],vrs['MassFlowC']]
    # vr_outputs4F = [vrs['MassFlow4'],vrs['MassFlowF']]
    vr_outputdp = [vrs['PressureDropL1'],vrs['PressureDropL2'],vrs['PressureDropL3'],vrs['PressureDropR1'],vrs['PressureDropR2'],vrs['PressureDropR3'],vrs['PressureDropR4']]

    fmu = FMU2Slave(guid=model_description.guid,
                        unzipDirectory=unzipdir,
                        modelIdentifier=model_description.coSimulation.modelIdentifier,
                        instanceName='instance1')

    fmu.instantiate()
    fmu.setupExperiment(startTime=0.0)
    fmu.enterInitializationMode()
    fmu.setReal(vr_inputs, inputList)
    fmu.exitInitializationMode()

    #dump(fmu_file)
    time = 0.0
    stop_time = 86400
    step_size = 1e-1
    threshold = 2.0

    rows = {'time':[],'input':[],'outputFlow':[], 'dp':[], 'dp_sum':[], 'inputcolor':[]}#rows = {'time':[],'input':[],'outputL':[],'outputR':[], 'RB':[], 'LB':[], 'inputcolor':[]}

    while time < stop_time:

        # NOTE: the FMU.get*() and FMU.set*() functions take lists of
        # value references as arguments and return lists of values

        # set the input
        
        # perform one step
        fmu.doStep(currentCommunicationPoint=time, communicationStepSize=step_size)

        # advance the time
        time += step_size
        # Inform the model about an accepted step and check for step events
        step_event = fmu.completed_integrator_step()
        
        # Check for time and state events
        time_event = time in kwargs['time']
        #state_event = True if True in ((event_ind_new>0.0) != (event_ind>0.0)) else False

        # Event handling
        if time_event:
            fmu.setupExperiment()

        inputs = []
        outputsFlow = []
        outputsdp = []

        # get the values for 'inputs' and 'outputs[4]'
        for i in vr_inputs:
            inputs.append(fmu.getReal([i])[0])
        for j in vr_outputsFlow:
            outputsFlow.append(fmu.getReal([j])[0])
        for n in vr_outputdp:
            outputsdp.append(fmu.getReal([n])[0])

        #OFLOW = np.multiply(np.array(outputsFlow),60)
        InPut = np.array(inputs)

        # append the results
        rows['time'].append(time)
        rows['input'].append(inputs)
        rows['outputFlow'].append(outputsFlow)
        #rows['Flow_B'].append(np.std(OFLOW))#var改为std
        rows['dp'].append(outputsdp)
        rows['dp_sum'].append(np.sum(outputsdp))
        rows['inputcolor'].append(np.sum(InPut))

        # use the threshold to terminate the simulation
        if outputsFlow[0] > threshold:
            print("Threshold reached at t = %g s" % time)
            break

    fmu.terminate()
    fmu.freeInstance()

    # clean up
    shutil.rmtree(unzipdir, ignore_errors=True)

    #print(time,inputs,outputsL,outputsR,np.var(OL),np.var(OR))

    lastOFLOW = np.multiply(np.array(rows['outputFlow'][-1]),60)
    lastdpsum = rows['dp_sum'][-1]
    # lastInput = rows['input'][-1]
    # lastinputL = np.array([0.4-lastInput[0],0.4-lastInput[1],0.4-lastInput[2],0.2-lastInput[3],0.2-lastInput[4]])

    def cal_error(array):
        tempo_re = []
        aveg = np.mean(array)
        for i in range(len(array)):
            tempo_re.append(abs((array[i]-aveg)/aveg))
        re = np.array(tempo_re)
        return np.mean(re)

    # convert the results to a structured NumPy array
    mydataFrame = pd.DataFrame({'time':rows['time'],'input':rows['input'],'outputFlow':rows['outputFlow'],'dp':rows['dp'],'dp_sum':rows['dp_sum'],
                                'inputcolor':rows['inputcolor']})
    myotherdataFrame = pd.DataFrame({'X_dp':[lastdpsum],'Y_balance':[cal_error(lastOFLOW)]})

    mydataFrame.to_csv(os.path.join(dirLocation, str(count)+'_result.csv'))
    myotherdataFrame.to_csv(os.path.join(dirLocation, str(count)+'_result_after_process.csv'))

    

    return cal_error(lastOFLOW), lastdpsum#方差改成标准差max(np.var(lastO123ABC), np.var(lastO56DE), np.var(lastO4F)), np.sum(lastinputL)




# plot the results
# if show_plot:
#     plot_result(result)

# import pandas as pd
# import numpy as np
# import shutil
# from fmpy import *
# from fmpy import read_model_description, extract
# from fmpy.fmi2 import FMU2Slave
# from Counter_run_time import CallingCounter

# @CallingCounter
# def floFmu(**kwargs):
#     count = floFmu.count
#     """input a 5*1 list"""
#     inputList = kwargs['inputValue']

#     dirLocation = kwargs['dir']

#     fmu_file = 'fmu/easykjz_0308.fmu'
#     # simulate_fmu(fmu_file)
#     model_description = read_model_description(fmu_file)

#     unzipdir = extract(fmu_file)
#     vrs = {}
#     for variable in model_description.modelVariables:
#             vrs[variable.name] = variable.valueReference

#     vr_inputs = [vrs['[DiamLeft]'],vrs['[DiamMiddel]'],vrs['[DiamRight]'],vrs['[DiamLeft2]'],vrs['[DiamLeft3]']]#[vrs['[DiamLeft]'],vrs['[DiamMiddel]'],vrs['[DiamRight]']]
#     vr_outputs123ABC = [vrs['MassFlow1'],vrs['MassFlow2'],vrs['MassFlow3'],vrs['MassFlowA'],vrs['MassFlowB'],vrs['MassFlowC']]#[vrs['MassFlow1'],vrs['MassFlow2'],vrs['MassFlow3']]
#     vr_outputs56DE = [vrs['MassFlow5'],vrs['MassFlow6'],vrs['MassFlowD'],vrs['MassFlowE']]#[vrs['MassFlowA'],vrs['MassFlowB'],vrs['MassFlowC']]
#     vr_outputs4F = [vrs['MassFlow4'],vrs['MassFlowF']]

#     fmu = FMU2Slave(guid=model_description.guid,
#                         unzipDirectory=unzipdir,
#                         modelIdentifier=model_description.coSimulation.modelIdentifier,
#                         instanceName='instance1')

#     fmu.instantiate()
#     fmu.setupExperiment(startTime=0.0)
#     fmu.enterInitializationMode()
#     fmu.setReal(vr_inputs, inputList)
#     fmu.exitInitializationMode()

#     #dump(fmu_file)
#     time = 0.0
#     stop_time = 15
#     step_size = 1e-1
#     threshold = 2.0

#     rows = {'time':[],'input':[],'output123ABC':[],'output56DE':[], 'output4F':[], '123ABC_B':[], '56DE_B':[], '4F_B':[], 'inputcolor':[]}#rows = {'time':[],'input':[],'outputL':[],'outputR':[], 'RB':[], 'LB':[], 'inputcolor':[]}

#     while time < stop_time:

#         # NOTE: the FMU.get*() and FMU.set*() functions take lists of
#         # value references as arguments and return lists of values

#         # set the input
        
#         # perform one step
#         fmu.doStep(currentCommunicationPoint=time, communicationStepSize=step_size)

#         # advance the time
#         time += step_size

#         inputs = []
#         outputs123ABC = []
#         outputs56DE = []
#         outputs4F = []

#         # get the values for 'inputs' and 'outputs[4]'
#         for i in vr_inputs:
#             inputs.append(fmu.getReal([i])[0])
#         for j in vr_outputs123ABC:
#             outputs123ABC.append(fmu.getReal([j])[0])
#         for k in vr_outputs56DE:
#             outputs56DE.append(fmu.getReal([k])[0])
#         for m in vr_outputs4F:
#             outputs4F.append(fmu.getReal([m])[0])

#         O123ABC = np.multiply(np.array(outputs123ABC),60)
#         O56DE = np.multiply(np.array(outputs56DE),60)
#         O4F = np.multiply(np.array(outputs4F),60)
#         InPut = np.array(inputs)

#         # append the results
#         rows['time'].append(time)
#         rows['input'].append(inputs)
#         rows['output123ABC'].append(outputs123ABC)
#         rows['output56DE'].append(outputs56DE)
#         rows['output4F'].append(outputs4F)
#         rows['123ABC_B'].append(np.std(O123ABC))#var改为std
#         rows['56DE_B'].append(np.std(O56DE))
#         rows['4F_B'].append(np.std(O4F))
#         rows['inputcolor'].append(np.sum(InPut))

#         # use the threshold to terminate the simulation
#         if outputs123ABC[0] > threshold:
#             print("Threshold reached at t = %g s" % time)
#             break

#     fmu.terminate()
#     fmu.freeInstance()

#     # clean up
#     shutil.rmtree(unzipdir, ignore_errors=True)

#     #print(time,inputs,outputsL,outputsR,np.var(OL),np.var(OR))

#     lastO123ABC = np.multiply(np.array(rows['output123ABC'][-1]),60)
#     lastO56DE = np.multiply(np.array(rows['output56DE'][-1]),60)
#     lastO4F = np.multiply(np.array(rows['output4F'][-1]),60)
#     lastInput = rows['input'][-1]
#     lastinputL = np.array([0.4-lastInput[0],0.4-lastInput[1],0.4-lastInput[2],0.2-lastInput[3],0.2-lastInput[4]])

#     # convert the results to a structured NumPy array
#     mydataFrame = pd.DataFrame({'time':rows['time'],'input':rows['input'],'output123ABC':rows['output123ABC'],'output56DE':rows['output56DE'],
#                                 'output4F':rows['output4F'],'123ABC_B':rows['123ABC_B'],'56DE_B':rows['56DE_B'],'4F_B':rows['4F_B'],'inputcolor':rows['inputcolor']})
#     myotherdataFrame = pd.DataFrame({'X_input':[np.sum(lastinputL)],'Y_balance':[max(np.std(lastO123ABC), np.std(lastO56DE), np.std(lastO4F))]})

#     mydataFrame.to_csv(os.path.join(dirLocation, str(count)+'_result.csv'))
#     myotherdataFrame.to_csv(os.path.join(dirLocation, str(count)+'_result_after_process.csv'))

#     return max(np.std(lastO123ABC), np.std(lastO56DE), np.std(lastO4F)), np.sum(lastinputL)#方差改成标准差max(np.var(lastO123ABC), np.var(lastO56DE), np.var(lastO4F)), np.sum(lastinputL)



# # plot the results
# # if show_plot:
# #     plot_result(result)