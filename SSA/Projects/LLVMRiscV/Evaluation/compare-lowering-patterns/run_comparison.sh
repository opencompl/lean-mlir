#! /bin/bash
export PYTHONPATH=$PYTHONPATH:~/lean-mlir
python3 ../benchmarks/generate.py --num 10 --jobs 30 --llvm_opt all -l
python3 ../mca-analysis/run_mca.py 
python3 compare_lowerings.py