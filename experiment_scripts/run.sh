#!/bin/bash

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --savedir one_cycle_bin_task  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --savedir one_cycle_bin_task  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --savedir one_cycle_bin_task  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 20 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --savedir two_cycle_bin_task  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 20\
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --savedir two_cycle_bin_task  > /dev/null &

seq 1 10 | xargs -I RUN_NO -P 10 python experiment.py \
    --cycle 10 20\
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --savedir two_cycle_bin_task > /dev/null 