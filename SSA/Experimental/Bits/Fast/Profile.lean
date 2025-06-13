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
import SSA.Experimental.Bits.TestPredicates
import Lean
open Lean Elab Meta

def timeElapsedMs (x : IO α) : IO (α × Int) := do
    let tStart ← IO.monoMsNow
    let b ← x
    let tEnd ← IO.monoMsNow
    return (b, tEnd - tStart)

/-!
We disable closed term extraction to make sure that the evaluation of
FSM.decideAllZeroes is not lifted into a top-level closed term whose value is computed at initialization.
-/
set_option compiler.extract_closed false in
unsafe def main : IO Unit := do
  initSearchPath (← findSysroot)
  Lean.withImportModules #[{ module := `Lean.Elab.Tactic.BVDecide}, {module := `Std.Tactic.BVDecide}]
      (opts := {}) (trustLevel := 0) fun env => do
    let ctxCore : Core.Context := { fileName := "SynthCadicalFile", fileMap := FileMap.ofString "" }
    let sCore : Core.State :=  { env }
    let ctxMeta : Meta.Context := {}
    let sMeta : Meta.State := {}
    let ctxTerm : Term.Context :=  { declName? := .some (Name.mkSimple s!"problem")}
    let sTerm : Term.State := {}
    for p in Bits.testPredicates do
      IO.println (repr p)
      for i in [0:1] do
        IO.println s!"Iteration #{i + 1} of Running Algorithm"
        let fsm := predicateEvalEqFSM p
        -- let (bPure, tElapsedPure) ← timeElapsedMs (IO.lazyPure fun () => decideIfZeros fsm.toFSM)
        let (bCadical, tElapsedCadical) ← timeElapsedMs do
          let (b, _coreState, _metaState, _termState) ←
            fsm.toFSM.decideIfZerosMUnverified 10 |>.toIO ctxCore sCore ctxMeta sMeta ctxTerm sTerm
          return b
        -- IO.println s!" (pure)     is all zeroes: '{bPure}' | time: '{tElapsedPure}' ms"
        IO.println s!" (cadical)  is all zeroes: '{bCadical}' | time: '{tElapsedCadical}' ms"
        IO.println "--"
  return ()
