#!/bin/bash

dir='../results01'

bash run.sh --task task.three_rules_random --network ModIndExHebbFFN --config_file ./configs/in3-out3/modindexhebb_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_cyclic --network ModIndExHebbFFN --config_file ./configs/in3-out3/modindexhebb_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_static --network ModIndExHebbFFN --config_file ./configs/in3-out3/modindexhebb_genome.ini --savedir $dir 
