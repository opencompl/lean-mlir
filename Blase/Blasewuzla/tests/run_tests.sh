#!/usr/bin/env bash
# Run blasewuzla on all test cases in this directory.
# Tests under unsat/  expect the solver to output "unsat".
# Tests under unknown/ expect the solver to output "unknown".
#
# Usage: ./run_tests.sh [--verbose]
#   Run from the Blase/ directory (the lake project root).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLASE_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"  # lean-mlir/Blase

BINARY="$BLASE_DIR/.lake/build/bin/blasewuzla"

VERBOSE=0
if [[ "${1:-}" == "--verbose" ]]; then
  VERBOSE=1
fi

if [[ ! -x "$BINARY" ]]; then
  echo "ERROR: blasewuzla binary not found at $BINARY"
  echo "Run 'lake build blasewuzla' from $BLASE_DIR first."
  exit 1
fi

PASS=0
FAIL=0

run_test() {
  local file="$1"
  local expected="$2"

  local result
  result=$("$BINARY" "$file" 2>/dev/null)

  if [[ "$result" == "$expected" ]]; then
    if [[ $VERBOSE -eq 1 ]]; then
      echo "PASS [$expected]: $(basename "$file")"
    fi
    PASS=$((PASS + 1))
  else
    echo "FAIL: $(basename "$file")  expected='$expected'  got='$result'"
    FAIL=$((FAIL + 1))
  fi
}

for f in "$SCRIPT_DIR/unsat"/*.smt2; do
  run_test "$f" "unsat"
done

for f in "$SCRIPT_DIR/unknown"/*.smt2; do
  run_test "$f" "unknown"
done

echo ""
echo "Results: $PASS passed, $FAIL failed"

if [[ $FAIL -ne 0 ]]; then
  exit 1
fi
