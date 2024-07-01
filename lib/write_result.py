
import numpy as np

def epoch_result(path, run_id, epoch, env_epoch, args):
    pm_weisheng_avg = np.mean(env_epoch['pm_weisheng'])
    pm_wujun_avg = np.mean(env_epoch['pm_wujun'])
    pm_huanchong_avg = np.mean(env_epoch['pm_huanchong'])
    p_weisheng = np.max(env_epoch['dp_weisheng'])
    p_wujun = np.max(env_epoch['dp_wujun'])
    p_huanchong = np.max(env_epoch['dp_huanchong'])
    energy = np.max(env_epoch['supply'])

    #按非线性加权计算能耗结果，方法1
    #action_avg = np.mean(env_epoch['action'])
    # 可以认为是计算了平均开启挡位，因为计算方法是(1/3*action1 + 2/3*action2 + 1*action3 ) 是否可以认为是线性的能耗加权计算方式，方法2
    #action_avg = (np.sum(env_epoch['action'] == 1/3)+np.sum(env_epoch['action'] == 2/3)+np.sum(env_epoch['action'] == 1))/env_epoch.shape[0], 
    #这种算法取消了加权系数，认为是计算了开启时间占总时间的比例
    # action_0 = np.sum(env_epoch['action'] == 0)/env_epoch.shape[0]
    # action_1 = np.sum(env_epoch['action'] == 1/3)/env_epoch.shape[0]
    # action_2 = np.sum(env_epoch['action'] == 2/3)/env_epoch.shape[0]
    # action_3 = np.sum(env_epoch['action'] == 1)/env_epoch.shape[0]

    pm_weisheng_over_58 = np.sum(env_epoch['pm_weisheng']/1000 > 58.5)
    pm_wujun_over_58 = np.sum(env_epoch['pm_wujun']/1000 > 58.5)
    pm_huanchong_over_58 = np.sum(env_epoch['pm_huanchong']/1000 > 58.5)
    total_result = np.sum(env_epoch['total_reward'])

    with open(path,'a') as fd:
        fd.write(run_id)
        fd.write(',')
        fd.write(str(epoch))
        fd.write(',')
        fd.write(str(total_result))
        fd.write(',')
        fd.write(str(pm_weisheng_avg))
        fd.write(',')
        fd.write(str(pm_wujun_avg))
        fd.write(',')
        fd.write(str(pm_huanchong_avg))
        fd.write(',')
        fd.write(str(p_weisheng))
        fd.write(',')
        fd.write(str(p_wujun))
        fd.write(',')
        fd.write(str(p_huanchong))
        fd.write(',')
        fd.write(str(pm_weisheng_over_58))
        fd.write(',')
        fd.write(str(pm_wujun_over_58))
        fd.write(',')
        fd.write(str(pm_huanchong_over_58))
        fd.write(',')
        fd.write('NA')
        fd.write(',')
        fd.write(str(energy))
        fd.write(',')       
        fd.write(str(args.epoch))
        fd.write(',')
        fd.write(str(args.BATCH))
        fd.write(',')
        fd.write(str(round(args.actor_lr,5)))
        fd.write(',')
        fd.write(str(round(args.critic_lr,5)))
        fd.write(',')
        fd.write(str(round(args.gamma,5)))
        fd.write(',')
        fd.write(str(round(args.w_pm,5)))
        fd.write(',')
        fd.write(str(round(args.w_energy,5)))
        fd.write(',')
        fd.write(str(round(args.w_dp,5)))
        fd.write(',')
        fd.write(str(args.save_step))
        fd.write(',')
        fd.write(str(args.A_up))
        fd.write(',')
        fd.write(str(args.C_up))
        fd.write(',')
        fd.write(str(round(args.epsilon,5)))
        fd.write(',')
        fd.write(str(round(args.grad_norm,5)))               
        fd.write('\n')
