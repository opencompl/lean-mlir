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


open Std Sat AIG in
/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
def Circuit.toAIG [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
    ExtendingEntrypoint aig :=
  match c with
  | .fals => ⟨aig.mkConstCached false, by apply  LawfulOperator.le_size⟩
  | .tru => ⟨aig.mkConstCached true, by apply  LawfulOperator.le_size⟩
  | .var b v =>
    let out := mkAtomCached aig v
    have AtomLe := LawfulOperator.le_size (f := mkAtomCached) aig v
    if b then
      ⟨out, by simp [out]; omega⟩
    else
      let notOut := mkNotCached out.aig out.ref
      have NotLe := LawfulOperator.le_size (f := mkNotCached) out.aig out.ref
      ⟨notOut, by simp only [notOut, out] at NotLe AtomLe ⊢; omega⟩
  | .and l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .or l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .xor l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := l.toAIG aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := r.toAIG aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩

open Std Sat AIG Tactic BVDecide Frontend in
def TacticContext.new (lratPath : System.FilePath) (config : BVDecideConfig) :
    TermElabM TacticContext := do
  -- Account for: https://github.com/arminbiere/cadical/issues/112
  let config :=
    if System.Platform.isWindows then
      { config with binaryProofs := false }
    else
      config
  let exprDef ← Lean.Elab.Term.mkAuxName `_expr_def
  let certDef ← Lean.Elab.Term.mkAuxName `_cert_def
  let reflectionDef ← Lean.Elab.Term.mkAuxName `_reflection_def
  let solver ← determineSolver
  trace[Meta.Tactic.sat] m!"Using SAT solver at '{solver}'"
  return {
    exprDef,
    certDef,
    reflectionDef,
    solver,
    lratPath,
    config
  }
where
  determineSolver : Lean.Elab.TermElabM System.FilePath := do
    let opts ← getOptions
    let option := sat.solver.get opts
    if option == "" then
      let cadicalPath := (← IO.appPath).parent.get! / "cadical" |>.withExtension System.FilePath.exeExtension
      if ← cadicalPath.pathExists then
        return cadicalPath
      else
        return "cadical"
    else
      return option


open Std Sat AIG Tactic BVDecide Frontend in
def checkCircuitTautoAux [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  let cfg : BVDecideConfig := {}
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let c := c.not -- we're checking TAUTO, so check that negation is UNSAT.
    let ⟨entrypoint, hEntrypoint⟩ := c.toAIG AIG.empty
    let ⟨entrypoint, labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath (trimProofs := true) (timeout := 1000) (binaryProofs := true)
    match out with 
    | .error _model => return false 
    | .ok _cert => return true


/-- 
An axiom that tracks that a theorem is true because of our currently unverified
'decideIfZerosM' decision procedure.
-/
axiom decideIfZerosMAx {p : Prop} : p

def Circuit.decLeCadical {α : Type} [DecidableEq α] [Fintype α] [Hashable α]
  (c : Circuit α) (c' : Circuit α) : TermElabM { b : Bool // b ↔ c ≤ c' } := do 
 -- Justified by Circuit.le_iff_implies 
 let impliesCircuit := c.implies c'
 let ret ← checkCircuitTautoAux impliesCircuit
 return ⟨ret, decideIfZerosMAx⟩


def FSM.decideIfZerosMCadical  {arity : Type _} [DecidableEq arity]  (fsm : FSM arity) : TermElabM Bool := 
  decideIfZerosM Circuit.decLeCadical fsm
/--
Reflect an expression of the form:
  ∀ ⟦(w : Nat)⟧ (← focus)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.

Reflection code adapted from `elabNaticeDecideCoreUnsafe`,
which explains how to create the correct auxiliary definition of the form
`decideProprerty = true`, such that our goal state after using `ofReduceBool` becomes
⊢ ofReduceBool decideProperty = true

which is then indeed `rfl` equal to `true`.
-/
def reflectUniversalWidthBVsWithCadical (g : MVarId) : TermElabM (List MVarId) := do
  let ws ← Reflect.findExprBitwidths (← g.getType)
  let ws := ws.toArray
  if h0: ws.size = 0 then throwError "found no bitvector in the target: {indentD (← g.getType)}"
  else if hgt: ws.size > 1 then
    let (w1, wExample1) := ws[0]
    let (w2, wExample2) := ws[1]
    let mExample := f!"{w1} → {wExample1}" ++ f!"{w2} → {wExample2}"
    throwError "found multiple bitvector widths in the target: {indentD mExample}"
  else
    -- we have exactly one width
    let (w, wExample) := ws[0]

    -- We can now revert hypotheses that are of this bitwidth.
    let g ← Reflect.revertBvHyps g

    -- Next, after reverting, we have a goal which we want to reflect.
    -- we convert this goal to NNF
    let .some g ← NNF.runNNFSimpSet g
      | logInfo m!"Converting to negation normal form automatically closed goal."
        return[]
    logInfo m!"goal after NNF: {indentD g}"

    let .some g ← Simplifications.runPreprocessing g
      | logInfo m!"Preprocessing automatically closed goal."
        return[]
    logInfo m!"goal after preprocessing: {indentD g}"

    -- finally, we perform reflection.
    let result ← Reflect.reflectPredicateAux ∅ (← g.getType) w
    result.bvToIxMap.throwWarningIfUninterpretedExprs

    logInfo m!"predicate (repr): {indentD (repr result.e)}"

    let bvToIxMapVal ← result.bvToIxMap.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    logInfo m!"goal after reflection: {indentD g}"

    -- Log the finite state machine size, and bail out if we cross the barrier.
    let fsm := predicateEvalEqFSM result.e |>.toFSM 
    let isTrueForall ← fsm.decideIfZerosMCadical
    if isTrueForall
    then do
      let gs ← g.apply (mkConst ``decideIfZerosMAx [])
      if gs.isEmpty
      then return gs
      else 
        throwError "Expected application of 'decideIfZerosMAx' to close goal, but failed. {indentD g}"
    else
      throwError "failed to prove goal, since decideIfZerosM established that theorem is not true."
      return [g]
      

syntax (name := bvAutomataCircuitCadical) "bv_automata_circuit_cadical" (Lean.Parser.Tactic.config)? : tactic


open Tactic in
@[tactic bvAutomataCircuitCadical]
def evalBvAutomataCircuit : Tactic := fun
| `(tactic| bv_automata_circuit $[$cfg]?) => do
   let g ← getMainGoal
   setGoals (← reflectUniversalWidthBVsWithCadical g)
| _ => throwUnsupportedSyntax

open Lean Elab Meta in
/-!
We disable closed term extraction to make sure that the evaluation of
FSM.decideAllZeroes is not lifted into a top-level closed term whose value is computed at initialization.
-/
set_option compiler.extract_closed false in
unsafe def main : IO Unit := do
  Lean.withImportModules #[{ module := `Lean.Tactic.BVDecide}] (opts := {}) (trustLevel := 0) fun env => do
    initSearchPath (← findSysroot)
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

        let tStart ← IO.monoMsNow
        let b := fsm.toFSM.decideIfZerosMCadical 

        let ctxCore : Core.Context := { fileName := "SynthCadicalFile", fileMap := FileMap.ofString "" }
        let sCore : Core.State :=  { env }
        let ctxMeta : Meta.Context := {}
        let sMeta : Meta.State := {}
        let ctxTerm : Term.Context := {}
        let sTerm : Term.State := {}
        let (b, _coreState, _metaState, _termState) ← b.toIO ctxCore sCore ctxMeta sMeta ctxTerm sTerm

        let tEnd ← IO.monoMsNow
        IO.println s!"  is all zeroes: '{b}' | time: '{(tEnd - tStart) / 1000}' seconds"
        IO.println "--"
  return ()
