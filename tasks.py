import math
import matplotlib.pyplot as plt

def eval_fitness(net, step:int, cycle:int, verbose = False) -> float:

    error = 0.0
    expected = []
    got_output = []


    for s in range (step):

        cyclic_input = s * 2 * math.pi / cycle
        target_output = (math.sin(cyclic_input) + 1.0 ) / 2

        expected.append(target_output)

        # Get output phase
        net_input = [1.0, 0.0, 0.0, 0.0]
        output = net.activate(net_input)[0]
        got_output.append(output)
        difference = target_output - output

        if(verbose):
            print('expected output: {} got output: {}'.format(target_output, output))

        # Caliculate error
        error += math.log ( abs (target_output - output) +1 ) 

        # Feedback phase
        net_input = [0.0, 1.0, output, difference]
        net.activate(net_input)

    error /= step

    #draw graph
    if(verbose):
        x = range(1, step+1)
        y1 = expected
        y2 = got_output

        plt.plot(x, y1)
        plt.plot(x, y2)
        plt.show()

    assert(error <= 1.0)

    return 1.0 - error

class net_dummy:
    def activate(self, input):
        return [0.5]

if __name__=='__main__':
    n = net_dummy()
    fitness = eval_fitness(n, 100, 10,verbose=True)
    print(fitness)