#!/bin/bash

dir='../results_dir/2actions_noise_0_md_0'

bash run.sh --task gym_tasks.single_cyclic_task --generation 2000 --network ModExHebbRNN --config_file ./configs/in4-out2/modexhebb_genome_rnn.ini --savedir $dir --job_no 10 \
bash run.sh --task gym_tasks.multi_cyclic_task --generation 2000 --network ModExHebbRNN --config_file ./configs/in4-out2/modexhebb_genome_rnn.ini --savedir $dir --job_no 10 \
bash run.sh --task gym_tasks.single_cyclic_task --generation 2000 --network ModExHebbFFN --config_file ./configs/in4-out2/modexhebb_genome_ffn.ini --savedir $dir --job_no 10 \
bash run.sh --task gym_tasks.multi_cyclic_task --generation 2000 --network ModExHebbFFN --config_file ./configs/in4-out2/modexhebb_genome_ffn.ini --savedir $dir --job_no 10
