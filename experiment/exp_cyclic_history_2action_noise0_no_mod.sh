#!/bin/bash
set -euo

dir='../results_dir/2actions_noise_0_no_mod'

if [ ! -d $dir ]; then
	mkdir $dir
fi

cp $0 $dir/

bash run_task_parallel.sh --task gym_tasks.single_cyclic_task --generation 2000 --network ModExHebbRNN --config_file ./configs/in4-out2/modexhebb_genome_rnn.ini --savedir $dir --job_no 10 --checkpoint_interval 10 &\
bash run_task_parallel.sh --task gym_tasks.multi_cyclic_task --generation 2000 --network ModExHebbRNN --config_file ./configs/in4-out2/modexhebb_genome_rnn.ini --savedir $dir --job_no 10 --checkpoint_interval 10 &\
bash run_task_parallel.sh --task gym_tasks.single_cyclic_task --generation 2000 --network ModExHebbFFN --config_file ./configs/in4-out2/modexhebb_genome_ffn.ini --savedir $dir --job_no 10 --checkpoint_interval 10 &\
bash run_task_parallel.sh --task gym_tasks.multi_cyclic_task --generation 2000 --network ModExHebbFFN --config_file ./configs/in4-out2/modexhebb_genome_ffn.ini --savedir $dir --job_no 10 --checkpoint_interval 10
