#!/bin/bash
set -euxo pipefail

cd ..
LANG=C
savedir=$(date | tr ' ' '-')
mkdir ./$savedir
echo "実験するんだわ～ $savedir" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/random_cycle_task > /dev/null &&
    echo "task1-1 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/random_cycle_task > /dev/null &&
    echo "task1-2 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/random_cycle_task > /dev/null &&
    echo "task1-3 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/10-20_cycle_task > /dev/null &&
    echo "task2-1 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/10-20_cycle_task > /dev/null &&
    echo "task2-2 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20\
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/10-20_cycle_task > /dev/null &&
    echo "task2-3 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \ 
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/15_cycle_task > /dev/null &&
    echo "task3-1 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/15_cycle_task > /dev/null &&
    echo "task3-2 終了" | ./rocket

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $savedir/15_cycle_task > /dev/null &&
    echo "task3-3 終了" | ./rocket