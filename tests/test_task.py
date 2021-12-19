import os
import sys
import unittest
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
import task

class Test_three_rules_random(unittest.TestCase):
    def test_eval_fitness(self):
        mytask = task.three_rules_random(network_type=dummy_net, test=True)
        mynet = dummy_net()
        print(mytask.network_type)
        fitness = mytask.eval_fitness(mynet)
        assert(0.0 <= fitness <= 1.0)

class Test_three_rules_cyclic(unittest.TestCase):
    def test_eval_fitness(self):
        mytask = task.three_rules_cyclic(network_type=dummy_net, test=True)
        mynet = dummy_net()
        print(mytask.network_type)
        fitness = mytask.eval_fitness(mynet)
        assert(0.0 <= fitness <= 1.0)

class Test_three_rules_static(unittest.TestCase):
    def test_eval_fitness(self):
        mytask = task.three_rules_static(network_type=dummy_net, test=True)
        mynet = dummy_net()
        print(mytask.network_type)
        fitness = mytask.eval_fitness(mynet)
        assert(0.0 <= fitness <= 1.0)

class dummy_net:
    def activate(self, input):
        return [0,0,0]

if __name__=='__main__':
    unittest.main()