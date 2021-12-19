#!/bin/bash

dir='../results01'

bash run.sh --task task.three_rules_random --network HebbFFN --config_file ./configs/in3-out3/default_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_static --network HebbFFN --config_file ./configs/in3-out3/default_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_cyclic --network HebbFFN --config_file ./configs/in3-out3/default_genome.ini --savedir $dir
