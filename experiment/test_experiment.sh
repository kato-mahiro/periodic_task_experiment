#!/bin/bash

dir='../results_test'

bash run.sh --task gym_tasks.static_cyclic_task --generation 100 --network ModExHebbRNN --config_file ./configs/in4-out1/modexhebb_genome_rnn.ini --savedir $dir --job_no 10
