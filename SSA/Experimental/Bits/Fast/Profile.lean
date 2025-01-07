/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We profile slow problems in this file.

```
$ lake build bv-circuit-profile; samply record .lake/build/bin/bv-circuit-profile
```

Authors: Siddharth Bhat
-/
import SSA.Experimental.Bits.Fast.Reflect


def preds : Array Predicate := #[
  Predicate.eq
    (Term.add
      (Term.sub (Term.neg (Term.not (Term.xor (Term.var 0) (Term.var 1)))) (Term.shiftL (Term.var 1) 1))
      (Term.not (Term.var 0)))
    (Term.sub
      (Term.neg (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1)))))
      (Term.add (Term.and (Term.var 0) (Term.var 1)) (Term.shiftL (Term.and (Term.var 0) (Term.var 1)) 1)))
  ]


/-!
We disable closed term extraction to make sure that the evaluation of
FSM.decideAllZeroes is not lifted into a top-level closed term whose value is computed at initialization.
-/
set_option compiler.extract_closed false in
def main : IO Unit := do
  for p in preds do
    for i in [0:4] do
      IO.println (repr p)
      let fsm := predicateEvalEqFSM p
      IO.println s!"Iteration #{i + 1}"
      let tStart ← IO.monoMsNow
      let b := decideIfZeros fsm.toFSM
      let tEnd ← IO.monoMsNow
      IO.println s!"  is all zeroes: '{b}' | time: '{(tEnd - tStart) / 1000}' seconds"
      IO.println "--"
  return ()
