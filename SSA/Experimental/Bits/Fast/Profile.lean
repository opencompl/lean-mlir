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
import Lean
open Lean 

open Lean Elab Meta
#check Lean.Core.CoreM.toIO

/-
/--
Run a `CoreM α` in a fresh `Environment` with specified `modules : List Name` imported.
-/
def CoreM.withImportModules {α : Type} (modules : Array Name) (run : CoreM α)
    (searchPath : Option SearchPath := none) (options : Options := {})
    (trustLevel : UInt32 := 0) (fileName := "") :
    IO α := unsafe do
  if let some sp := searchPath then searchPathRef.set sp
  Lean.withImportModules (modules.map (Import.mk · false)) options trustLevel fun env =>
    let ctx := {fileName, options, fileMap := default}
    let state := {env}
    Prod.fst <$> (CoreM.toIO · ctx state) do
-/


def preds : Array Predicate := #[
  Predicate.eq
    (Term.add
      (Term.sub (Term.neg (Term.not (Term.xor (Term.var 0) (Term.var 1)))) (Term.shiftL (Term.var 1) 1))
      (Term.not (Term.var 0)))
    (Term.sub
      (Term.neg (Term.not (Term.or (Term.var 0) (Term.not (Term.var 1)))))
      (Term.add (Term.and (Term.var 0) (Term.var 1)) (Term.shiftL (Term.and (Term.var 0) (Term.var 1)) 1)))
  ]


#check Tactic.BVDecide.External.satQuery

-- 

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
