import random
import math
import matplotlib.pyplot as plt
from numpy import save

def binary_task(net, step:int, cycle:int, is_increase=False, draw_graph=False, show_graph = False, savepath = None, is_bh_only = True) -> float:

    error = 0.0
    expected = []
    got_output = []

    step_cnt = 0
    target_output = 0.0
    
    # for random switching
    same_rule_cnt = 0
    random_cycle = random.randint(10, 20)

    for s in range (step):

        step_cnt += 1

        if cycle != 0:
            if(step_cnt % cycle == 0):
                if(target_output == 0.0):
                    target_output = 1.0
                elif(target_output == 1.0):
                    target_output = 0.0
                if(is_increase):
                    cycle += 1
                step_cnt = 1
            
            
        # if cycle is 0, switch at random timing.
        else:
            if(same_rule_cnt == random_cycle):
                same_rule_cnt = 0
                random_cycle = random.randint(10, 20)
                #print(random_cycle)
                if(target_output == 0.0):
                    target_output = 1.0
                elif(target_output == 1.0):
                    target_output = 0.0
            else:
                same_rule_cnt += 1


        expected.append(target_output)

        # Get output phase
        net_input = [1.0, 0.0, 0.0, 0.0]
        output = net.activate(net_input)[0]
        got_output.append(output)
        difference = target_output - output

        # Caliculate error
        if(is_bh_only):
            if( s < step // 2):
                error += 0
            else:
                error += abs(target_output - output) * 2

        else:
            error += abs(target_output - output)

        # Feedback phase
        net_input = [0.0, 1.0, output, difference]
        net.activate(net_input)

    error /= step

    if(draw_graph):
        draw(step = step, expected = expected, got_output = got_output, show_graph = show_graph, savepath = savepath)
    assert(error <= 1.0)

    return 1.0 - error

def draw(step, expected, got_output, show_graph, savepath):
    x = range(1, step+1)
    y1 = expected
    y2 = got_output

    fig = plt.figure()

    plt.plot(x, y1, linestyle = "-", color = "blue", label = "expected output")
    plt.plot(x, y2, linestyle = "dashed", color = "red", label = "model's output")
    plt.grid(linestyle='dotted')
    plt.xlabel("step")
    plt.title("Model's behaviour")
    plt.legend(loc = "upper left")
    if(show_graph):
        plt.show()

    #save graph
    if(savepath):
        fig.savefig(savepath)
        print('Graph is saved.')

    plt.close()

class net_dummy:
    def activate(self, input):
        return [random.random()]

if __name__=='__main__':
    n = net_dummy()

    fitness = binary_task(n, 150, 10, is_increase=False, draw_graph=True, show_graph=True,savepath="./hoge")
    print(fitness)

    #fitness = sinwave_task(n, 100, 20, draw_graph=True, show_graph=True,savepath="./hoge")
    #print(fitness)