#!/bin/bash
set -euxo pipefail

cd ..
LANG=C
savedir=$(TZ=JST-9 date | tr ' ' '-')
mkdir ./$savedir
echo "実験開始(全設定での一括実行) $savedir" | ./rocket

cp ./experiment_scripts/run_all.sh $savedir

#
# ランダムルール変更タスクの実験
#
seq 10  | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/random > /dev/null &&
    echo "random-1 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/random > /dev/null &&
    echo "random-2 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/random > /dev/null &&
    echo "random-3 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/random > /dev/null &&
    echo "random-4 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/random > /dev/null &&
    echo "random-5 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 0 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/random > /dev/null &&
    echo "random-6 終了" | ./rocket &

#
# 世代・生涯で固定タスクの設定
#
seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-1 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-2 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-3 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-4 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-5 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 15 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/static > /dev/null &&
    echo "fixed-6 終了" | ./rocket &


#
# 各世代で10通りタスクの設定
#
seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-1 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-2 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-3 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-4 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-5 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 11 12 13 14 15 16 17 18 19 20 \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/10_cycles > /dev/null &&
    echo "10通り-6 終了" | ./rocket &

#
# 増加(ダイナミクスが変動)タスクの設定
#
seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-1 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-2 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only True \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-3 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ExFeedForwardNetwork \
    --config ./config/exgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-4 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ModFeedForwardNetwork \
    --config ./config/modgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-5 終了" | ./rocket &

seq 1 10 | xargs -I RUN_NO -P 10 python ./experiment.py \
    --cycle 10 \
    --is_increase True \
    --task binary_task \
    --model ExModFeedForwardNetwork \
    --config ./config/exmodgenome_config.ini \
    --run_id RUN_NO \
    --generation 2000 \
    --is_bh_only False \
    --savedir $savedir/increasing > /dev/null &&
    echo "increasing-6 終了" | ./rocket &