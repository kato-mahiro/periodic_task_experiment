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
    parser.add_argument('--savedir', type=str, help="dir name to save the results.", default = "output", required=False)
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
            net = modneat.nn.ExFeedForwardNetwork.create(genome, config)
            genome.fitness += tasks.binary_task(net, step=100, cycle=c)
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
    config = modneat.Config(modneat.ExGenome,
                            modneat.DefaultReproduction,
                            modneat.DefaultSpeciesSet,
                            modneat.DefaultStagnation,
                            config_file)

    # Create the population, which is the top-level object for a NEAT run.
    p = modneat.Population(config)

    # Add a stdout reporter to show progress in the terminal.
    p.add_reporter(modneat.StdOutReporter(True))
    stats = modneat.StatisticsReporter()
    p.add_reporter(stats)
    p.add_reporter(modneat.Checkpointer(5, filename_prefix = out_dir + '/checkpoint-'))

    # Run for up to 300 generations.
    best_genome = p.run(eval_genomes, 30)

    # Display the best genome among generations.
    print('\nBest genome:\n{!s}'.format(best_genome))

    # Show behaviour of the most fit genome against training data.
    best_fitness_all_cycles = 0.0
    for c in task_cycles:
        net = modneat.nn.ExFeedForwardNetwork.create(best_genome, config)
        best_fitness = tasks.binary_task(net, step=100, cycle=c, draw_graph = True, show_graph = True, savepath= out_dir + '/cycle_' + str(c) + '_model_behaviour.png')
        print('fitness of cycle {} : {}'.format(c, best_fitness))

        best_fitness_all_cycles += best_fitness
    print('best fitness of all cycles average: {}'.format(best_fitness_all_cycles / len(task_cycles)))

    # Visualize the experiment results
    node_names = {-1:'get_output_phase_flag', 
                  -2: 'feedback_phase_flag', 
                  -3:'previous_output_value', 
                  -4:'difference_value', 
                  0:'output'}

    visualize.draw_net(config, best_genome, True, node_names=node_names, directory=out_dir)
    visualize.plot_stats(stats, ylog=False, view=True, filename=os.path.join(out_dir, 'avg_fitness.svg'))
    visualize.plot_species(stats, view=True, filename=os.path.join(out_dir, 'speciation.svg'))

def clean_output():
    if os.path.isdir(out_dir):
        # remove files from previous run
        shutil.rmtree(out_dir)

    # create the output directory
    os.makedirs(out_dir, exist_ok=False)

if __name__ == '__main__':
    args = create_parser()

    global task_cycles
    task_cycles = args.cycle

    global out_dir
    out_dir = os.path.join(os.getcwd(), args.savedir)

    # Determine path to configuration file. This path manipulation is
    # here so that the script will run successfully regardless of the
    # current working directory.
    config_path = os.path.join(os.getcwd(), './config/exgenome_config.ini')

    # Clean results of previous run if any or init the ouput directory
    clean_output()

    # Run the experiment
    run_experiment(config_path)
