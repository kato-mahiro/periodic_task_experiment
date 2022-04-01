import numpy as np
import gym
import random

"""
常に観測値として1を返す環境
環境に対して取るべき行動が周期的に切り替わり、
それに応じて報酬が決定される。
"""

class StaticCyclicEnv0(gym.Env):
    def __init__(self):
        super().__init__()
        ACTION_NUM = 2
        self.action_space = gym.spaces.Discrete(ACTION_NUM)
        self.observation_space = gym.spaces.Box(
            low = 1,
            high = 1,
            shape = [1],
            dtype = np.int
        )
        self.reward_range = [0, 1]
        self.reset()

    def reset(self):
        self.step_cnt = 0
        self.cycle_cnt = 0
        self.cycle = 20
        self.done = False
        return self.observe()

    def step(self, action):
        observation = self.observe()
        reward = random.random()
        self.done = False
        return observation, reward, self.done, {}

    def observe(self):
        return 1