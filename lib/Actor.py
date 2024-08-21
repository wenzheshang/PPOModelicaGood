"""
===================================
该部分为神经网络模型定义代码
定义了模型结构，进行更新的方式
输入为9维state
输出为3维连续action
===================================
"""
# 用于连续动作的PPO
from errno import EPIPE
import numpy as np
import torch
from torch import nn
from torch.nn import functional as F
from torch.distributions import Normal

class Actor(nn.Module):
    """
    神经网络结构
    # 全连接1
    # 全连接2
    # ReLU
    网络输出是动作的mu和sigma
    """
    def __init__(self,
                 n_features,
                 n_neuron):
        super(Actor, self).__init__()
        self.linear = nn.Sequential(
            nn.Linear(in_features=n_features,
                      out_features=n_neuron,
                      bias=True),
            nn.ReLU()
        )
        self.mu = nn.Sequential(
            nn.Linear(in_features=n_neuron,
                      out_features=3,
                      bias=True),
            nn.Tanh()
        )
        self.sigma = nn.Sequential(
            nn.Linear(in_features=n_neuron,
                      out_features=3,
                      bias=True),
            nn.Softplus()
        )

    def forward(self, x):
        y = self.linear(x)
        mu = 0.5 * self.mu(y) + 0.5 #(0,1)
        sigma = self.sigma(y) + 0.001
        return mu, sigma

class Critic(nn.Module):
    """
    神经网络结构
    # 全连接1
    # 全连接2
    # ReLU
    输出是状态价值
    """
    def __init__(self,
                 n_features,
                 n_neuron):
        super(Critic, self).__init__()
        self.net = nn.Sequential(
            nn.Linear(in_features=n_features,
                      out_features=n_neuron,
                      bias=True),
            nn.ReLU(),
            nn.Linear(in_features=n_neuron,
                      out_features=1,
                      bias=True),
        )
    def forward(self, x):
        return self.net(x)

class PPO(object):

    def __init__(self,
                 n_features,
                 n_neuron,
                 actor_learning_rate,
                 critic_learning_rate,
                 A_UPDATE_STEPS,
                 C_UPDATE_STEPS,
                 epsilon,
                 max_grad_norm  # 梯度剪裁参数                
                 ):
        self.actor_lr = actor_learning_rate
        self.critic_lr = critic_learning_rate
        self.actor_old = Actor(n_features, n_neuron)
        self.actor = Actor(n_features, n_neuron)
        self.critic = Critic(n_features, n_neuron)
        self.actor_optimizer = torch.optim.Adam(params=self.actor.parameters(),
                                          lr=self.actor_lr)
        self.critic_optimizer = torch.optim.Adam(params=self.critic.parameters(),
                                                 lr=self.critic_lr)
        self.max_grad_norm = max_grad_norm  # 梯度剪裁参数
        self.A_UPDATE_STEPS = A_UPDATE_STEPS
        self.C_UPDATE_STEPS = C_UPDATE_STEPS
        self.epsilon = epsilon

    def update(self, s, a, r, log_old, br_next_state):
        """
        :param s: np.array(buffer_s)
        :param a: np.array(buffer_a)
        :param r: np.array(buffer_r)
        :param log_old: np.array(buffer_log_old)
        :param next_state: np.array(buffer_next_state)
        :return: update actor net and critic net
        """
        self.actor_old.load_state_dict(self.actor.state_dict())
        # 从buffer中取出state, action, reward, old_action_log_prob, next_state放在tensor上
        state = torch.FloatTensor(s)
        action = torch.FloatTensor(a)
        discounted_r = torch.FloatTensor(r)  # discounted_r是target_v
        next_state = torch.FloatTensor(br_next_state)

        # 使用actor_old得到old_action_log_prob

        mu_old, sigma_old = self.actor_old(state)
        dist_old = Normal(mu_old, sigma_old)
        old_action_log_prob = dist_old.log_prob(action).detach()

        # target_v也是累积折扣奖励
        target_v = discounted_r

        # 优势函数advantage，也是td_error
        advantage = (target_v - self.critic(state)).detach()

        #advantage = (advantage - advantage.mean()) / (advantage.std()+1e-6)  # sometimes helpful by movan

        # update actor net
        # clipping method, find this is better (OpenAI's paper)
        # update actor net
        for _ in range(self.A_UPDATE_STEPS):
            ## update step as follows:
            # compute new_action_log_prob
            mu, sigma = self.actor(state)
            n = Normal(mu, sigma)
            new_action_log_prob = n.log_prob(action)  # !!!划重点，新策略动作值的log_prob，是新策略得到的分布上找到action对应的log_prob值

            # ratio = new_action_prob / old_action_prob
            ratio = torch.exp(new_action_log_prob - old_action_log_prob)

            # L1 = ratio * td_error, td_error也叫作advatange
            L1 = ratio * advantage

            # L2 = clip(ratio, 1-epsilon, 1+epsilon) * td_error
            L2 = torch.clamp(ratio, 1-self.epsilon, 1+self.epsilon) * advantage

            # loss_actor = -min(L1, L2)
            actor_loss = -torch.min(L1, L2).mean()

            # optimizer.zero_grad()
            self.actor_optimizer.zero_grad()
            # actor_loss.backward()
            actor_loss.backward()
            # 梯度裁剪,只解决梯度爆炸问题，不解决梯度消失问题
            nn.utils.clip_grad_norm_(self.actor.parameters(), self.max_grad_norm)
            # actor_optimizer.step()
            self.actor_optimizer.step()

        # update critic net
        for _ in range(self.C_UPDATE_STEPS):
            # critic的loss是td_error也就是advantage，可以是td_error的L1范数也可以是td_error的L2范数
            critic_loss = nn.MSELoss(reduction='mean')(self.critic(state), target_v)
            # optimizer.zero_grad()
            self.critic_optimizer.zero_grad()
            # 反向传播
            critic_loss.backward()
            # 梯度裁剪,只解决梯度爆炸问题，不解决梯度消失问题
            nn.utils.clip_grad_norm_(self.critic.parameters(), self.max_grad_norm)
            # optimizer.step()
            self.critic_optimizer.step()
            
        self.acloss = actor_loss
        self.crloss = critic_loss

    def choose_action(self, s):
        """
        选择动作
        :param s:
        :return:
        """
        # 状态s放在torch.tensor上
        # actor net输出mu和sigma
        # 根据mu和sigma采样动作
        # 返回动作和动作的log概率值
        s = torch.FloatTensor(s)
        with torch.no_grad():
            mu, sigma = self.actor(s)
        # print(s, mu, sigma)
        dist = Normal(mu, sigma)
        action = dist.sample()
        action_log_prob = dist.log_prob(action)
        action = action.clamp(0, 1)
        action = action.numpy()
        action = np.around(action,4)
        # #if s[-1]+s[-2]+s[-3] != 0:
        #     action = np.array([1.0,1.0,1.0])
        # # else:
        # #     action = np.array([0,0,0])
        return action, action_log_prob.numpy()

    def get_v(self, s):
        """
        状态价值函数
        :param s:
        :return:
        """
        # 状态s放在torch.tensor上
        # critic net输出value
        s = torch.FloatTensor(s)
        with torch.no_grad():
            value = self.critic(s)
        return value.item()
