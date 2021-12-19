import os
import sys
import unittest
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
import task

class Test_three_rules_random(unittest.TestCase):
    def test(self):
        mytask = task.three_rules_cyclic()
        print(self.mytask.network_type)

class dummy_net:
    def activate(self, input):
        return [0,0,0]

if __name__=='__main__':
    unittest.main()