#!/bin/bash

set -euo pipefail

ln -fs ./utils/parse_options.sh ./parse_options.sh

run_id=0
network_type=FeedForwardNetwork
genome_type=DefaultGenome
config=./config/genome_config.ini

. utils/parse_options.sh || exit 1

echo $run_id

python experiment.py \
    --task task.three_rules_random \
    --network_type FeedForwardNetwork \
    --genome_type DefaultGenome \
    --config ./config/genome_config.ini \
    --generation 20 \
    --run_id $run_id