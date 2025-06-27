#!/usr/bin/env bash

cd $(git rev-parse --show-toplevel)
cd bv-evaluation/

python3 compare.py hackersdelight -j8 -r1
python3 compare.py instcombine -j8 -r1

python3 collect.py hackersdelight
python3 collect.py instcombine

python3 plot.py hackersdelight
python3 plot.py instcombine

python3 collect-stats-bv-decide.py