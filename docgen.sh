set -o xtrace
set -e 
lake -Kenv=dev update
lake -Kenv=dev build SSA:docs
