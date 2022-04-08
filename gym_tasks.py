import numpy
import myenvs.myenvs as myenvs
import gym

class static_cyclic_task:
    def __init__(self, network_type):
        self.E = gym.make('static_cyclic_env-v0', cycle = 10, action_num = 2)
        self.network_type = network_type
    
    def eval_fitness(self, net):
        normal_fitness = 0.0
        bonus_fitness = 0.0
        history = [] #各サイクル毎の正解数、ボーナスタイミングで正解できたが分かるような履歴
        net.reset()
        observation = self.E.reset()
        while(True):
            #get output phase
            input_vector = [1.0, observation, 0.0, 0.0] #bias_input, observation, normal_feedbak, bonus_feedback
            action = numpy.argmax(net.activate(input_vector))
            observation, reward, done, info = self.env.step(action)
            if(reward == 1.0):
                normal_fitness += 1.0
                feedback1 = 1.0
                if(info['is_bonus']):
                    bonus_fitness += 1.0
                    feedback2 = 1.0
                else:
                    feedback2 = 0.0
            else:
                feedback1 = 0.0
                feedback2 = 0.0

            #feedback phase
            net.activate([1.0, 0.0, feedback1, feedback2])

            if(done == True):
                break

        fitness = 0.0
        fitness += normal_fitness / (200 * 2)
        fitness += bonus_fitness / self.E.info['bonus_max'] * 2
        return fitness, history

class dynamic_cyclic_task:
    def __init__(self, network_type):
        pass

class random_cyclic_task:
    def __init__(self,network_type):
        pass

if __name__=='__main__':
    t = static_cyclic_task(0)