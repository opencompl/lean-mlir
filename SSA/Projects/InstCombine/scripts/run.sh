#!/usr/bin/env bash
set -e
set -o xtrace
cd ../../../..

python3 SSA/Projects/InstCombine/scripts/test-gen.py
# python3 SSA/Projects/InstCombine/scripts/proof-gen.py
# python3 SSA/Projects/InstCombine/scripts/read-logs.py
