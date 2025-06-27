
pushd $(git rev-parse --show-toplevel)

echo $PWD

pushd bv-evaluation
./compare-automata-automata-circuit-jsonl.py --db compare.jsonl --prodrun  -j5 
./plot-automata-automata-circuit-jsonl.py compare.jsonl
popd

pushd SSA/Experimental/Bits/Fast/Dataset2
./runner.py --db mba.sqlite3 -j10 --prod-run --timeout 8000
./plotter.py mba.sqlite3

popd
