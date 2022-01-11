#!/bin/bash

dir='../results04'

bash run.sh --task new_task.timing_random --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir &
bash run.sh --task new_task.timing_static --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir &
bash run.sh --task new_task.timing_random_generation --network ModExHebbFFN --config_file ./configs/in3-out1/modexhebb_genome.ini --savedir $dir
