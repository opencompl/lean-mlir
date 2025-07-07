#!/usr/bin/env bash

pushd $(git rev-parse --show-toplevel)

echo $PWD

pushd bv-evaluation
./compare-automata-automata-circuit-jsonl.py --db compare.jsonl -j4 --nfiles 3 --timeout 50
./plot-automata-automata-circuit-jsonl.py compare.jsonl
popd

pushd SSA/Experimental/Bits/Fast/Dataset2
./runner.py --db mba.sqlite3 -j4 --mba 3 --bv_decide 3 --bv_automata_classic 3 --kinduction_verified 3 --timeout 10
./plotter.py mba.sqlite3

popd
