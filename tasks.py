import math

def eval_fitness(net, step:int, cycle:int, verbose = False) -> float:

    error = 0.0

    for s in range (step):

        cyclic_input = s * 2 * math.pi / cycle
        target_output = (math.sin(cyclic_input) + 1.0 ) / 2

        # Get output phase
        net_input = [1.0, 0.0, 0.0, 0.0]
        output = net.activate(net_input)[0]
        difference = target_output - output

        if(verbose):
            print('expected output: {} got output: {}'.format(target_output, output))

        # Caliculate error
        error += math.log ( abs (target_output - output) +1 ) 

        # Feedback phase
        net_input = [0.0, 1.0, output, difference]
        net.activate(net_input)

    error /= step
    assert(error <= 1.0)

    return 1.0 - error

class net_dummy:
    def activate(self, input):
        return 0.5

if __name__=='__main__':
    n = net_dummy()
    fitness = eval_fitness(n, 100, 10)
    print(fitness)