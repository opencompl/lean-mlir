/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `bv_circuit_nnf` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Multiset.FinsetOps
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.Frontend.Syntax
import SSA.Experimental.Bits.Frontend.Preprocessing
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean

initialize Lean.registerTraceClass `Bits.Fast

/-
TODO:
- [?] BitVec.ofInt
    + This is sadly more subtle than I realized.
    + In the infinite width model, we have something like
        `∀ w, (negOnes w).getLsb 20 = true`
      However, this is patently untrue in lean, since we can instantiate `w = 0`.
    + So, it's not clear to me that this makes sense in the lean model of things?
      However, there is the funnny complication that we don't actually support getLsb,
      or right shift to access that bit before we reach that bitwidth, so the abstraction
      may still be legal, for reasons that I don't clearly understand now :P
    + Very interesting subtleties!
    + I currently add support for BitVec.ofInt, with the knowledge that I can remove it
      if I'm unable to prove soundness.
- [x] leftShift
- [x] Break down numeral multiplication into left shift:
       10 * z
       = z <<< 1 + 5 * z
       = z <<< 1 + (z + 4 * z)
       = z <<< 1 + (z + z <<< 2).
       Needs O(log |N|) terms.
    + Wrote the theorems needed to perform the simplification.
    + Need to write the `simproc`.

- [x] Check if the constants we support work for (a) hackers delight and (b) gsubhxor_proof
    + Added support for hacker's delight numerals. Checked by running files
        SSA/Projects/InstCombine/HackersDelight/ch2_1DeMorgan.lean
	      SSA/Projects/InstCombine/HackersDelight/ch2_2AdditionAndLogicalOps.lean
    + gsubhxor: We need support for `signExtend`, which we don't have yet :)
      I can add this.
- [ ] `signExtend`  support.
- [WONTFIX] `zeroExtend support: I don't think this is possible either, since zero extension
  is not a property that correctly extends across bitwidths. That is, it's not an
  'arithmetical' property so I don't know how to do it right!
- [ ] Write custom fast decision procedure for constant widths.
-/


/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

namespace BvDecide
open Std Sat AIG in

/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
@[nospecialize]
def toAIG [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
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
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := toAIG l aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := toAIG r aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .or l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := toAIG l aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := toAIG r aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
  | .xor l r =>
    let ⟨⟨aig, lhsRef⟩, lextend⟩ := toAIG l aig
    let ⟨⟨aig, rhsRef⟩, rextend⟩ := toAIG r aig
    let lhsRef := lhsRef.cast <| by
      dsimp only at rextend ⊢
      omega
    let input := ⟨lhsRef, rhsRef⟩
    let ret := aig.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) aig input
    ⟨ret, by dsimp only [ret] at lextend rextend ⊢; omega⟩
/-!
Helpers to use `bv_decide` as a solver-in-the-loop for the reflection proof.
-/

def cadicalTimeoutSec : Nat := 1000

attribute [nospecialize] toAIG
-- attribute [nospecialize] Std.Sat.AIG.Entrypoint.relabelNat'

open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitSatAux [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let ⟨entrypoint, _hEntrypoint⟩ := toAIG c AIG.empty
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return true
    | .ok _cert => return false


open Std Sat AIG Tactic BVDecide Frontend in
@[nospecialize]
def checkCircuitTautoAuxImpl [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let c := ~~~ c -- we're checking TAUTO, so check that negation is UNSAT.
    let ⟨entrypoint, _hEntrypoint⟩ := toAIG c AIG.empty
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return false
    | .ok _cert => return true

@[implemented_by checkCircuitTautoAuxImpl, nospecialize]
def checkCircuitTautoAux {α : Type} [DecidableEq α] [Hashable α] [Fintype α] (c : Circuit α) : TermElabM Bool := do
  return false

/--
An axiom that tracks that a theorem is true because of our currently unverified
'decideIfZerosM' decision procedure.
-/
axiom decideIfZerosMAx {p : Prop} : p

/--
An inductive type representing the variables in the unrolled FSM circuit,
where we unroll for 'n' steps.
-/
structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable


namespace Inputs

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ n') : Inputs ι n' where
  ix := ⟨i.ix, by omega⟩
  input := i.input

def map (f : ι → ι') (i : Inputs ι n) : Inputs ι' n where
  ix := i.ix
  input := f i.input

def univ [DecidableEq ι] [Fintype ι] (n : Nat) :
    { univ : Finset (Inputs ι n) // ∀ x : Inputs ι n, x ∈ univ } :=
  let ixs : Finset (Fin n) := Finset.univ
  let inputs : Finset ι := Finset.univ
  let out := ixs.biUnion
      (fun ix => inputs.map ⟨fun input => Inputs.mk ix input, by intros a b; simp⟩)
  ⟨out, by
    intros i
    obtain ⟨ix, input⟩ := i
    simp [out]
    constructor
    · apply Fintype.complete
    · apply Fintype.complete
  ⟩


instance [DecidableEq ι] [Fintype ι] :
    Fintype (Inputs ι n) where
  elems := univ n |>.val
  complete := univ n |>.property

/-- Format an Inputs -/
def format (f : ι → Format) (is : Inputs ι n) : Format :=
  f!"⟨{f is.input}@{is.ix}⟩"

end Inputs


inductive Vars (σ : Type) (ι : Type) (n : Nat)
| state (s : σ)
| inputs (is : Inputs ι n)
deriving DecidableEq, Hashable

instance [DecidableEq σ] [DecidableEq ι] [Fintype σ] [Fintype ι] : Fintype (Vars σ ι n) where
  elems :=
    let ss : Finset σ := Finset.univ
    let ss : Finset (Vars σ ι n) := ss.map ⟨Vars.state, by intros s s'; simp⟩
    let ii : Finset (Inputs ι n) := Finset.univ
    let ii : Finset (Vars σ ι n) := ii.map ⟨Vars.inputs, by intros ii ii'; simp⟩
    ss ∪ ii
  complete := by
    intros x
    simp
    rcases x with s | i  <;> simp

def Vars.format (fσ : σ → Format) (fι : ι → Format) {n : Nat} (v : Vars σ ι n) : Format :=
  match v with
  | .state s => fσ s
  | .inputs is => is.format fι

structure CircuitStats where
  safetySize : Nat := 0
  indSize : Nat := 0
deriving Repr, Inhabited, DecidableEq, Hashable

@[nospecialize]
partial def decideIfZerosAuxTermElabM {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (p : FSM arity)
    -- c0K = 0 <-> ∀ i ≤ iter, p.eval env i = 0
    (c0K : Circuit (Vars p.α arity iter))
    -- cK = 0 <-> ∀ p.eval env iter = 0
    (cK : Circuit (Vars p.α arity iter))
    : TermElabM (Bool × CircuitStats) := do
  trace[Bits.Fast] s!"### K-induction (iter {iter}) ###"
  let formatα : p.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  trace[Bits.Fast] m!"c0K: {formatCircuit (Vars.format formatα formatArity) c0K}"
  trace[Bits.Fast] m!"cK: {formatCircuit (Vars.format formatα formatArity) cK}"
  if iter ≥ maxIter && maxIter != 0 then
    throwError s!"ran out of iterations, quitting"
    return (false, {safetySize := c0K.size })
  let cKSucc : Circuit (Vars p.α arity (iter + 1)) :=
    cK.bind fun v =>
      match v with
      | .state a => p.nextBitCirc (some a) |>.map fun v =>
        match v with
        | .inl a => .state a
        | .inr x => .inputs <| Inputs.latest x
      | .inputs i => .var true (.inputs (i.castLe (by omega)))
  trace[Bits.Fast] m!"cKSucc: {formatCircuit (Vars.format formatα formatArity) cKSucc}"
  -- circuit of the output at state (k+1)
  -- circuit of the outputs from 0..K, all ORd together, ignoring the new 'arity' output.
  let c0KAdapted : Circuit (Vars p.α arity (iter + 1)) := c0K.map fun v =>
      match v with
      | .state a => .state a
      | .inputs i => .inputs (i.castLe (by omega))
  trace[Bits.Fast] m!"c0KAdapted: {formatCircuit (Vars.format formatα formatArity) c0K}"
  let c0KSucc : Circuit (Vars p.α arity (iter + 1)) :=  (c0KAdapted ||| cKSucc)
  let c0KSuccWithInit : Circuit (Vars Empty arity (iter+1)) := c0KSucc.assignVars fun v _hv =>
    match v with
    | .state a => .inr (p.initCarry a) -- assign init state
    | .inputs is => .inl (.inputs is)
  trace[Bits.Fast] m!"safety circuit / c0KSuccWithInit: {formatCircuit (Vars.format formatEmpty formatArity) c0KSuccWithInit}"
  let c0KWithInit : Circuit (Vars Empty arity (iter)) := c0K.assignVars fun v _hv =>
    match v with
    | .state a => .inr (p.initCarry a) -- assign init state
    | .inputs is => .inl (.inputs is)
  trace[Bits.Fast] m!"safety circuit / c0KWithInit: {formatCircuit (Vars.format formatEmpty formatArity) c0KWithInit}"
  if ← checkCircuitSatAux c0KSuccWithInit
  then
    trace[Bits.Fast] s!"Safety property failed on initial state."
    return (false, { safetySize := c0KSuccWithInit.size })
  else
    trace[Bits.Fast] s!"Safety property succeeded on initial state. Building next state circuit..."
    let tStart ← IO.monoMsNow
    -- [(c0K = 0 => c0KSucc = 0)] <-> [(!c => !c') = 1]
    -- [(!!c || !c')= 1]
    -- [(c || !c') = 1] ← { this is the formula we use }
    trace[Bits.Fast] s!"C0KAdapted: {formatCircuit (Vars.format formatα formatArity) c0KAdapted}"
    trace[Bits.Fast] s!"CKSucc: {formatCircuit (Vars.format formatα formatArity) cKSucc}"
    let impliesCircuit : Circuit (Vars p.α arity (iter + 1)) := c0KAdapted ||| ~~~ c0KSucc
    let indCircuit := impliesCircuit
    -- let indCircuit := indCircuit.map fun v =>
    --    match v with
    --    | .state a => .state a
    --    | .inputs i => .inputs (i.castLe (by omega))
    -- let indCircuit := indCircuit ||| impliesCircuit
    -- let formatαβarity : p.α ⊕ (β ⊕ arity) → Format := sorry
    trace[Bits.Fast] m!"induction hyp circuit: {formatCircuit (Vars.format formatα formatArity) impliesCircuit}"
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.Fast] s!"Built state circuit of size: '{c0KAdapted.size + cKSucc.size}' (time={tElapsedSec}s)"
    trace[Bits.Fast] s!"Establishing inductive invariant with cadical..."
    let tStart ← IO.monoMsNow
    -- let le : Bool := sorry
    let le ← checkCircuitTautoAux indCircuit
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    if le then
      trace[Bits.Fast] s!"Inductive invariant established! (time={tElapsedSec}s)"
      return (true, { indSize := indCircuit.size, safetySize := c0KSuccWithInit.size })
    else
      trace[Bits.Fast] s!"Unable to establish inductive invariant (time={tElapsedSec}s). Recursing..."
      decideIfZerosAuxTermElabM (iter + 1) maxIter p c0KSucc cKSucc


@[nospecialize]
def _root_.FSM.decideIfZerosMUnverified  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM (Bool × CircuitStats) :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    let c : Circuit (Vars fsm.α arity 0) := (fsm.nextBitCirc none).fst.map Vars.state
    decideIfZerosAuxTermElabM 0 maxIter fsm c c

end BvDecide

end Reflect
