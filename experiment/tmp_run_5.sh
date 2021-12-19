#!/bin/bash

dir='../results01'

bash run.sh --task task.three_rules_random --network IndExHebbFFN --config_file ./configs/in3-out3/indexhebb_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_cyclic --network IndExHebbFFN --config_file ./configs/in3-out3/indexhebb_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_static --network IndExHebbFFN --config_file ./configs/in3-out3/indexhebb_genome.ini --savedir $dir 
