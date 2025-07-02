#!/usr/bin/env bash

pushd $(git rev-parse --show-toplevel)

echo $PWD

pushd bv-evaluation
./compare-automata-automata-circuit-jsonl.py --db compare.jsonl --prodrun  -j5
./plot-automata-automata-circuit-jsonl.py compare.jsonl
popd

pushd SSA/Experimental/Bits/Fast/Dataset2
./runner.py --db mba.sqlite3 -j12 --timeout 540 --memout 8000 --mba 2500 --bv_decide 2500 --bv_automata_classic 2500 --kinduction_verified 1600
./plotter.py mba.sqlite3

popd
