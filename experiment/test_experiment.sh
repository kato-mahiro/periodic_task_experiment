#!/bin/bash

dir='../results_test'

bash run.sh --task gym_tasks.multi_cyclic_task --generation 10 --network ModExHebbRNN --config_file ./configs/in4-out1/modexhebb_genome_rnn.ini --savedir $dir --job_no 10
