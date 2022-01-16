#!/bin/bash

dir='../results11_no_weight_changing'

bash run.sh --task new_task.changing_random --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.changing_static --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.changing_random_generation --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.changing_random --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir & \
bash run.sh --task new_task.changing_static --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir & \
bash run.sh --task new_task.changing_random_generation --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir & \
bash run.sh --task new_task.timing_random --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.timing_static --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.timing_random_generation --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir & \
bash run.sh --task new_task.timing_random --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir & \
bash run.sh --task new_task.timing_static --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir & \
bash run.sh --task new_task.timing_random_generation --network ModExHebbRNN --config_file ./configs/in3-out1/modexhebb_genome_rnn.ini --savedir $dir
