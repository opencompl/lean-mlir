#!/usr/bin/env bash
# Run blasewuzla on all test cases in this directory.
# Tests under sat/     expect exit code 10  (SAT / counterexample found).
# Tests under unsat/   expect exit code 20  (UNSAT / proven safe).
# Tests under unknown/ expect exit code  0  (unknown / exhausted iterations).
# Exit codes follow the CaDiCaL / HWMCC convention.
#
# Usage: ./run_tests.sh [--verbose]
#   Can be run from any directory inside the repository.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLASE_DIR="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)/Blase"

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
  local expected_exit="$2"

  local actual_exit=0
  echo "Running $file..."
  lake env "$BINARY" "$file" 2>&1 || actual_exit=$?

  # The solver is always allowed to return unknown (exit 0).
  if [[ "$actual_exit" -eq "$expected_exit" || "$actual_exit" -eq 0 ]]; then
    if [[ $VERBOSE -eq 1 ]]; then
      if [[ "$actual_exit" -eq 0 && "$expected_exit" -ne 0 ]]; then
        echo "PASS [exit=0, unknown]: $(basename "$file")"
      else
        echo "PASS [exit=$expected_exit]: $(basename "$file")"
      fi
    fi
    PASS=$((PASS + 1))
  else
    echo "FAIL: $(basename "$file")  expected_exit=$expected_exit  got_exit=$actual_exit"
    FAIL=$((FAIL + 1))
  fi
}

for f in "$SCRIPT_DIR/sat"/*.smt2; do
  run_test "$f" 10
done

for f in "$SCRIPT_DIR/unsat"/*.smt2; do
  run_test "$f" 20
done

if [[ -d "$SCRIPT_DIR/unknown" ]]; then
  for f in "$SCRIPT_DIR/unknown"/*.smt2; do
    run_test "$f" 0
  done
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"

if [[ $FAIL -ne 0 ]]; then
  exit 1
fi
