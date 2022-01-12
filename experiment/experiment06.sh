#!/bin/bash

dir='../results06'

bash run.sh --task new_task.timing_random_generation --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir &
bash run.sh --task new_task.timing_random_generation --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir
