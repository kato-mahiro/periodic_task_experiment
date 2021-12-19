#!/bin/bash

dir='../results01'

bash run.sh --task task.three_rules_random --network FeedForwardNetwork --config_file ./configs/in3-out3/default_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_static --network FeedForwardNetwork --config_file ./configs/in3-out3/default_genome.ini --savedir $dir &
bash run.sh --task task.three_rules_cyclic --network FeedForwardNetwork --config_file ./configs/in3-out3/default_genome.ini --savedir $dir
