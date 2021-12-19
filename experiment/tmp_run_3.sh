#!/bin/bash

dir='../results01'

bash run.sh --task task.three_rules_random --network ModHebbFFN --config_file ./configs/in3-out3/mod_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_static --network ModHebbFFN --config_file ./configs/in3-out3/mod_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_cyclic --network ModHebbFFN --config_file ./configs/in3-out3/mod_genome.ini --savedir $dir
