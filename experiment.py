#
# This file provides source code to conduct experiment 
#

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

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cycle', nargs="+", type=int, help="list of cycle no of experiment.", required=True)
    parser.add_argument('--is_increase', type=str, help="rule of dynamics. if True, cycle is increased. ", default = "False", required = False)
    parser.add_argument('--savedir', type=str, help="dir name to save the results.", default = "outputs", required=False)
    parser.add_argument('--config', type=str, help="name of config file.", required = True)
    parser.add_argument('--model', type=str, help="name of using model. RecurrentNetwork,  FeedForwardNetwork, ExFeedForwardNetwork, ModFeedForwardNetwork, ExModFeedForwardNetwork ", required = True)
    parser.add_argument('--task', type=str, help="name of using task. binary_task or sinwave_task. ", default = "binary_task", required = False)
    parser.add_argument('--generation', type=int, help="gneration length of the experiment.", default = 1000, required = False)
    parser.add_argument('--run_id', type=str, help="ID of the experiment.", default = '0', required = False)
    parser.add_argument('--is_bh_only', type=str, help="use only before half for fitness or, not", required = True)
    parser.add_argument('--is_use_previous', type=str, help="models use previous output or not", required = True)

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
            genome.fitness += eval('tasks.' + task_name + '(net, step = 150, cycle=c, is_increase=is_increase, is_bh_only = is_bh_only, is_use_previous = is_use_previous)')
        genome.fitness /= len(task_cycles)

def run_experiment(config_file):
    """
    The function to run XOR experiment against hyper-parameters 
    defined in the provided configuration file.
    The winner genome will be rendered as a graph as well as the
    important statistics of neuroevolution process execution.
    Arguments:
        config_file: the path to the file with experiment 
                    configuration
    """
    # Load configuration.
    if(model == 'RecurrentNetwork'):
        model_genome = modneat.DefaultGenome
    elif(model == 'FeedForwardNetwork'):
        model_genome = modneat.DefaultGenome
    elif(model == 'ExFeedForwardNetwork'):
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

    # Create the population, which is the top-level object for a NEAT run.
    p = modneat.Population(config)

    # Add a stdout reporter to show progress in the terminal.
    p.add_reporter(modneat.FileOutReporter(True, out_dir + '/result.txt'))
    stats = modneat.StatisticsReporter()
    p.add_reporter(stats)
    p.add_reporter(modneat.Checkpointer(5, filename_prefix = out_dir + '/checkpoints/checkpoint-'))

    # Run for up to generations.
    best_genome = p.run(eval_genomes, generation)

    # Display the best genome among generations.
    print('\nBest genome:\n{!s}'.format(best_genome))

    # Show behaviour of the most fit genome against training data.
    best_fitness_all_cycles = 0.0
    for c in task_cycles:
        net = eval('modneat.nn.' + model + '.create(best_genome,config)')
        #best_fitness = tasks.binary_task(net, step=100, cycle=c, draw_graph = True, show_graph = True, savepath= out_dir + '/cycle_' + str(c) + '_model_behaviour.png')
        best_fitness = eval( 'tasks.' + task_name + "(net, step=150, cycle=c, is_increase=is_increase, is_bh_only = is_bh_only, is_use_previous = is_use_previous,  draw_graph = True, show_graph = False, savepath= out_dir + '/cycle_' + str(c) + '_model_behaviour.png')")
        print('fitness of cycle {} : {}'.format(c, best_fitness))

        best_fitness_all_cycles += best_fitness
    print('best fitness of all cycles average: {}'.format(best_fitness_all_cycles / len(task_cycles)))

    # Visualize the experiment results
    node_names = {-1:'get_output_phase_flag', 
                  -2:'feedback_phase_flag', 
                  -3:'previous_output_value', 
                  -4:'difference_value', 
                  0:'output'}

    visualize.draw_net(config, best_genome, False, node_names=node_names, directory=out_dir)
    visualize.plot_stats(stats, ylog=False, view=False, filename=os.path.join(out_dir, 'avg_fitness.png'))
    visualize.plot_species(stats, view=False, filename=os.path.join(out_dir, 'speciation.png'))

def clean_output():
    if os.path.isdir(out_dir):
        # remove files from previous run
        shutil.rmtree(out_dir)

    # create the output directory
    os.makedirs(out_dir, exist_ok=False)
    os.makedirs(out_dir + '/checkpoints/', exist_ok=False)

if __name__ == '__main__':

    args = create_parser()

    global task_cycles
    task_cycles = args.cycle

    global is_increase
    if(args.is_increase == 'True'):
        is_increase = True
    elif(args.is_increase == 'False'):
        is_increase = False

    global model
    model = args.model

    global task_name
    task_name = args.task

    global generation
    generation = args.generation

    global is_bh_only
    if(args.is_bh_only == 'True'):
        is_bh_only = True
    elif(args.is_bh_only == 'False'):
        is_bh_only = False

    global is_use_previous
    if(args.is_use_previous == 'True'):
        is_use_previous = True
    elif(args.is_use_previous == 'False'):
        is_use_previous = False

    global out_dir
    out_dir = os.path.join(os.getcwd(), args.savedir + '_' + args.model + '/' + args.task+ str(args.cycle) + '_isIncrease_' + str(args.is_increase) + '_isBhOnly_' + str(args.is_bh_only) + '_isUsePre_' + str(args.is_use_previous) +   '_run_' +args.run_id)
    print('*** out_dir is {}'.format(out_dir))


    # Determine path to configuration file. This path manipulation is
    # here so that the script will run successfully regardless of the
    # current working directory.
    config_path = os.path.join(os.getcwd(), args.config)

    # Clean results of previous run if any or init the ouput directory
    clean_output()

    # Run the experiment
    run_experiment(config_path)
