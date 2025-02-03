#!/usr/bin/bash

# run experiments and collect data

python3 compare-leansat-vs-bitwuzla-llvm.py -j=256
python3 collect-data-llvm.py

python3 compare-leansat-vs-bitwuzla-llvm-symbolic.py -j=256
python3 collect-data-llvm-symbolic.py

python3 compare-leansat-vs-bitwuzla-hdel.py
python3 collect-data-hdel.py

python3 compare-leansat-vs-bitwuzla-hdel-symbolic.py
python3 collect-data-hdel-symbolic.py

python3 compare-leansat-vs-bitwuzla-alive.py
python3 collect-data-alive.py

source venv/bin/activate && cd plots && python3 plot.py all
