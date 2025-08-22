/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We profile slow problems in this file.

```
$ lake build bv-automata-profile; samply record .lake/build/bin/bv-automata-profile
```

Authors: Leo Stefanesco
-/
import BvDecideParametric.TestPredicates
import BvDecideParametric.AutoStructs.FormulaToAuto

def timeElapsedMs (x : Unit → α) : IO (α × Int) := do
    let tStart ← IO.monoMsNow
    let b := x ()
    let tEnd ← IO.monoMsNow
    return (b, tEnd - tStart)

/-!
We disable closed term extraction to make sure that the evaluation of
FSM.decideAllZeroes is not lifted into a top-level closed term whose value is computed at initialization.
-/
set_option compiler.extract_closed false in
unsafe def main (args : List String) : IO Unit := do
  let i := args.getD 0 "0"
  let i := i.toNat?.getD 0
  IO.println f!"Choosing predicate #{i}"
  let p := Bits.testPredicates[i]!
  let (f, transTime) ← timeElapsedMs (fun _ => formula_of_predicate p)
  IO.println f!"Formula translation took: {transTime}ms"
  let (m, nfaTime) ← timeElapsedMs (fun _ => nfaOfFormula f)
  IO.println f!"NFA construction took: {nfaTime}ms"
  let (b, univTime) ← timeElapsedMs (fun _ => m.isUniversal)
  IO.println f!"Universality check took: {univTime}ms"
  IO.println f!"Formula is true: {b}"

  return ()
