#!/usr/bin/env bash

pushd $(git rev-parse --show-toplevel)

echo $PWD

pushd bv-evaluation
./compare-automata-automata-circuit-jsonl.py --db compare.jsonl -j4
./plot-automata-automata-circuit-jsonl.py compare.jsonl
popd

pushd SSA/Experimental/Bits/Fast/Dataset2
./runner.py --db mba.sqlite3 -j4 --mba 100 --bv_decide 100 --bv_automata_classic 100 --kinduction_verified 100 --timeout 120
./plotter.py mba.sqlite3

popd
