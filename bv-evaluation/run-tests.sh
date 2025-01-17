# run experiments and collect data

python3 compare-leansat-vs-bitwuzla-llvm.py
python3 collect-leansat-vs-bitwuzla-llvm.py

python3 compare-leansat-vs-bitwuzla-llvm-symbolic.py
python3 collect-leansat-vs-bitwuzla-llvm-symbolic.py

python3 compare-leansat-vs-bitwuzla-hdel.py
python3 collect-leansat-vs-bitwuzla-hdel.py

python3 compare-leansat-vs-bitwuzla-hdel-symbolic.py
python3 collect-leansat-vs-bitwuzla-hdel-symbolic.py

python3 compare-leansat-vs-bitwuzla-alive.py
python3 collect-leansat-vs-bitwuzla-alive.py

cd plots
python3 plot.py