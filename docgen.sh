set -o xtrace
set -e 
lake -Kenv=dev update
lake exe cache get # load mathlib from cache
lake -Kenv=dev build SSA:docs
