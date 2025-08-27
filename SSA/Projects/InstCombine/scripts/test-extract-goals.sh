#!/usr/bin/env bash

set -o xtrace

pushd "$(git rev-parse --show-toplevel)" || exit 1

## The first argument to this script is passed on as `stride`, the second as `offset`.

python3 SSA/Projects/InstCombine/scripts/extract-goals.py $@
OUT=$(git diff SSA/Projects/InstCombine/tests/goals/)
git checkout -- SSA/Projects/InstCombine/ # undo all changes made by extraction.
echo "$OUT"
if [[ -n "$OUT" ]]; then
  echo "Goals have changed. Please commit the changes. ❌"
  exit 1
fi

echo "Goals are up-to-date ✅"

