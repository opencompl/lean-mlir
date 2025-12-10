#!/usr/bin/env bash
set -e
set -o xtrace

# The interesting problems are those that are generalizable, but we fail to solve.
rg '"isPotentiallyGeneralizable":true,"isSolvedByUs":false' bvtogeneralize.json | tee instcombine-problems-to-improve.json
