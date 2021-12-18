#!/bin/bash

SAVEDIR=ten_cycle_bin_task

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 1 2 3 4 5 6 7 8 9 10 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $SAVEDIR  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 1 2 3 4 5 6 7 8 9 10 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $SAVEDIR  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 1 2 3 4 5 6 7 8 9 10 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 1000 \
    --savedir $SAVEDIR > /dev/null