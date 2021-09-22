# The Python standard library import
import sys
import os
import shutil
import argparse

# The helper used to visualize experiment results
import visualize
# The definition file of tasks
import tasks
# The NEAT-Python library imports
sys.path.append(os.path.join( os.getcwd(), './neat-python') )
import modneat
from modneat.checkpoint import *

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cycle', nargs="+", type=int, help="list of cycle no of experiment.", required=True)
    parser.add_argument('--config', type=str, help="name of config file.", required = True)
    parser.add_argument('--model', type=str, help="name of using model. ExFeedForwardNetwork, ModFeedForwardNetwork, ExModFeedForwardNetwork ", required = True)
    parser.add_argument('--task', type=str, help="name of using task. binary_task or sinwave_task. ", default = "binary_task", required = False)
    parser.add_argument('--generation', type=int, help="gneration length of the experiment.", default = 1000, required = False)
    parser.add_argument('--run_id', type=str, help="ID of the experiment.", default = '0', required = False)
    parser.add_argument('--checkpoint', type=str, help="File path of checkpoint file.", default = None, required = False)

    args = parser.parse_args()
    return args

def eval_genomes(genomes, config):
    """
    The function to evaluate the fitness of each genome in 
    the genomes list. 
    The provided configuration is used to create feed-forward 
    neural network from each genome and after that created
    the neural network evaluated in its ability to solve
    XOR problem. As a result of this function execution, the
    the fitness score of each genome updated to the newly
    evaluated one.
    Arguments:
        genomes: The list of genomes from population in the 
                current generation
        config: The configuration settings with algorithm
                hyper-parameters
    """
    for genome_id, genome in genomes:
        genome.fitness = 0.0
        for c in (task_cycles):
            #net = modneat.nn.ExFeedForwardNetwork.create(genome, config)
            net = eval('modneat.nn.' + model + '.create(genome,config)')
            #genome.fitness += tasks.binary_task(net, step=100, cycle=c)
            genome.fitness += eval('tasks.' + task_name + '(net, step = 100, cycle=c)[0]')
        genome.fitness /= len(task_cycles)

if __name__ == '__main__':
    args = create_parser()
    p = Checkpointer.restore_checkpoint(args.checkpoint)
    print(p)

    global task_name
    task_name = args.task

    global task_cycles
    task_cycles = args.cycle

    global model
    model = args.model

    # Run for up to generations.
    best_genome = p.run(eval_genomes, 1)

    config_file = os.path.join(os.getcwd(), args.config)
    # Load configuration.
    if(model == 'ExFeedForwardNetwork'):
        model_genome = modneat.ExGenome
    elif(model == 'ModFeedForwardNetwork'):
        model_genome = modneat.ModGenome
    elif(model == 'ExModFeedForwardNetwork'):
        model_genome = modneat.ExModGenome
    config = modneat.Config(model_genome,
                            modneat.DefaultReproduction,
                            modneat.DefaultSpeciesSet,
                            modneat.DefaultStagnation,
                            config_file)

    # Show behaviour of the most fit genome against training data.
    best_fitness_all_cycles = 0.0
    for c in task_cycles:
        net = eval('modneat.nn.' + model + '.create(best_genome,config)')
        #best_fitness = tasks.binary_task(net, step=100, cycle=c, draw_graph = True, show_graph = True, savepath= out_dir + '/cycle_' + str(c) + '_model_behaviour.png')

        best_fitness, ratio = eval( 'tasks.' + task_name + "(net, step=100, cycle=c, draw_graph = True, show_graph = False, savepath= './cycle_' + str(c) + '_model_behaviour.png')")
        print('ベスト個体の適応度 (cycle {}) : {}'.format(c, best_fitness))
        print('後天的適応傾向: {}'.format(ratio))
        print (' ====== ')

        best_fitness_all_cycles += best_fitness
    print('best fitness of all cycles average: {}'.format(best_fitness_all_cycles / len(task_cycles)))