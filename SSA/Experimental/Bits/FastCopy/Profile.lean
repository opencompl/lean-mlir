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
import SSA.Experimental.Bits.FastCopy.Reflect
import Lean
open Lean Elab Meta

namespace Copy
def preds : Array Predicate := #[
(Copy.Predicate.binary Copy.BinaryPredicate.eq
                  (((((((((((Copy.Term.var 0).or (Copy.Term.var 1)).add
                                                    ((((Copy.Term.var 0).or (Copy.Term.var 1)).shiftL 1).add
                                                      (((((Copy.Term.var 0).or (Copy.Term.var 1)).shiftL 1).shiftL
                                                            1).shiftL
                                                        1))).add
                                                (((Copy.Term.var 0).xor (Copy.Term.var 1)).not.add
                                                  (((Copy.Term.var 0).xor (Copy.Term.var 1)).not.shiftL 1))).add
                                            ((Copy.Term.var 0).xor (Copy.Term.var 1))).sub
                                        ((Copy.Term.var 1).add ((Copy.Term.var 1).shiftL 1))).add
                                    (((Copy.Term.var 0).and (Copy.Term.var 1).not).not.add
                                      (((Copy.Term.var 0).and (Copy.Term.var 1).not).not.shiftL 1))).add
                                ((Copy.Term.var 0).add
                                  (((Copy.Term.var 0).shiftL 1).add
                                    ((((Copy.Term.var 0).shiftL 1).shiftL 1).shiftL 1)))).sub
                            ((((Copy.Term.var 0).or (Copy.Term.var 1)).not.shiftL 1).add
                              (((((Copy.Term.var 0).or (Copy.Term.var 1)).not.shiftL 1).shiftL 1).shiftL 1))).sub
                        ((((((Copy.Term.var 0).or (Copy.Term.var 1).not).not.shiftL 1).shiftL 1).shiftL 1).shiftL
                          1)).sub
                    (((Copy.Term.var 0).and (Copy.Term.var 1)).add
                      ((((((Copy.Term.var 0).and (Copy.Term.var 1)).shiftL 1).shiftL 1).shiftL 1).add
                        ((((((Copy.Term.var 0).and (Copy.Term.var 1)).shiftL 1).shiftL 1).shiftL 1).shiftL 1))))
                  ((((Copy.Term.var 0).and (Copy.Term.var 1).not).add
                        ((((Copy.Term.var 0).and (Copy.Term.var 1).not).shiftL 1).add
                          (((((Copy.Term.var 0).and (Copy.Term.var 1).not).shiftL 1).shiftL 1).add
                            ((((((Copy.Term.var 0).and (Copy.Term.var 1).not).shiftL 1).shiftL 1).shiftL 1).shiftL
                              1)))).sub
                    (((Copy.Term.var 0).not.shiftL 1).shiftL 1)))
  ]

def timeElapsedMs (x : IO α) : IO (α × Int) := do
    let tStart ← IO.monoMsNow
    let b ← x
    let tEnd ← IO.monoMsNow
    return (b, tEnd - tStart)

end Copy
open Copy
/-!
We disable closed term extraction to make sure that the evaluation of
FSM.decideAllZeroes is not lifted into a top-level closed term whose value is computed at initialization.
-/
set_option compiler.extract_closed false in
unsafe def main : IO Unit := do
  initSearchPath (← findSysroot)
  Lean.withImportModules #[{ module := `Lean.Elab.Tactic.BVDecide}, {module := `Std.Tactic.BVDecide}]
      (opts := {}) (trustLevel := 0) fun _env => do
    for p in preds do
      IO.println (repr p)
      let tStart ← IO.monoMsNow
      let nfa := nfaOfFormula (AutoStructs.formula_of_predicate p)
      let tMid ← IO.monoMsNow
      IO.println s!"It took {tMid - tStart}ms to compute the {nfa.m.stateMax} states of the NFA"
      let nfa := nfa.minimize
      let tMid' ← IO.monoMsNow
      IO.println s!"It took {tMid' - tMid}ms to determinize the NFA, into {nfa.m.stateMax} states"
      let res := nfa.isUniversal
      let tEnd ← IO.monoMsNow
      IO.println s!"It took {tEnd - tMid'}ms to compute whether the NFA is universal: {res}"
      IO.println "--"
  return ()
