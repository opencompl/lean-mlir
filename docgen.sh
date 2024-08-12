set -o xtrace
set -e
lake -R exe cache get # load mathlib from cache
lake -R build SSA:docs
