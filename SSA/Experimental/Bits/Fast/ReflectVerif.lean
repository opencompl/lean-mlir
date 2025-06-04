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
import SSA.Experimental.Bits.Fast.ForLean

import Lean

initialize Lean.registerTraceClass `Bits.FastVerif

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

namespace ReflectVerif
open Lean Meta Elab Tactic

namespace BvDecide
open Std Sat AIG

/--
Convert a 'Circuit α' into an 'AIG α' in order to reuse bv_decide's
bitblasting capabilities.
-/
@[nospecialize]
def _root_.Circuit.toAIGAux [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α) (aig : AIG α) :
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
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.val.aig
    let input := ⟨laig.val.ref.cast (by omega), raig.val.ref⟩
    let ret := raig.val.aig.mkAndCached input
    have Lawful := LawfulOperator.le_size (f := mkAndCached) raig.val.aig input
    ⟨ret, by
      simp [ret]
      apply Nat.le_trans _
      apply mkAndCached_le_size
      have hl' := laig.property
      have hr' := raig.property
      omega
    ⟩
  | .or l r =>
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.val.aig
    let input := ⟨laig.val.ref.cast (by omega), raig.val.ref⟩
    let ret := raig.val.aig.mkOrCached input
    have Lawful := LawfulOperator.le_size (f := mkOrCached) raig.val.aig input
    ⟨ret, by
      simp [ret]
      apply Nat.le_trans _
      apply mkOrCached_le_size
      have hl' := laig.property
      have hr' := raig.property
      omega⟩
  | .xor l r =>
    let laig := l.toAIGAux aig
    let raig := r.toAIGAux laig.val.aig
    let input := ⟨laig.val.ref.cast (by omega), raig.val.ref⟩
    let ret := raig.val.aig.mkXorCached input
    have Lawful := LawfulOperator.le_size (f := mkXorCached) raig.val.aig input
    ⟨ret, by
      simp [ret]
      apply Nat.le_trans _
      apply mkXorCached_le_size
      have hl' := laig.property
      have hr' := raig.property
      omega⟩

/-- The AIG preserves the size of the inputs. -/
theorem _root_.Circuit.toAIGAux_le_size [DecidableEq α] [Fintype α] [Hashable α]
  (c : Circuit α) (input : AIG α) :
  ∀ (idx : Nat) (_h : idx < input.decls.size), idx < (c.toAIGAux input).val.aig.decls.size := by
  intro idx h
  induction c generalizing input
  case tru =>
    simp [Circuit.toAIGAux]
    have := LawfulOperator.le_size (f := mkConstCached) input true
    omega
  case fals =>
    simp [Circuit.toAIGAux]
    have := LawfulOperator.le_size (f := mkConstCached) input false
    omega
  case var negated v =>
    simp [Circuit.toAIGAux]
    rcases negated with rfl | rfl
    case true =>
      simp only [↓reduceIte]; have := LawfulOperator.le_size (f := mkAtomCached) input v
      omega
    case false =>
      simp
      have := mkNotCached_le_size (aig := (input.mkAtomCached v).aig)
        (gate := (input.mkAtomCached v).ref)
      apply Nat.lt_of_lt_of_le _ this
      have := mkAtomCached_le_size (aig := input) v
      omega
  case and l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    apply Nat.lt_of_lt_of_le _
    apply mkAndCached_le_size
    apply hr
    apply hl
    exact h
  case or l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    apply Nat.lt_of_lt_of_le _
    apply mkOrCached_le_size
    apply hr
    apply hl
    exact h
  case xor l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    apply Nat.lt_of_lt_of_le _
    apply mkXorCached_le_size
    apply hr
    apply hl
    exact h

-- h1 : idx < input.decls.size
-- h2 : idx < (↑((l.and r).toAIGAux input)).aig.decls.size
-- ⊢ idx < (↑(l.toAIGAux input)).aig.decls.size
/--
We preserve the values of the AIG that are not touched by our current circuit.
-/
theorem _root_.Circuit.toAIGAux_decl_eq [DecidableEq α] [Fintype α] [Hashable α]
  (c : Circuit α) (input : AIG α) :
  ∀ (idx : Nat) (h1) (h2), (c.toAIGAux input).val.aig.decls[idx]'h2 = input.decls[idx] := by
  intro idx h1 h2
  induction c generalizing input
  case tru =>
    simp [Circuit.toAIGAux]
    rw [mkConstCached_decl_eq]
  case fals =>
    simp [Circuit.toAIGAux]
    rw [mkConstCached_decl_eq]
  case var negated v =>
    simp [Circuit.toAIGAux]
    rcases negated with rfl | rfl
    case true =>
      simp only [↓reduceIte]; rw [mkAtomCached_decl_eq]
    case false =>
      simp
      rw [mkNotCached_decl_eq]
      rw [mkAtomCached_decl_eq]
      have := mkAtomCached_le_size input v
      omega
  case and l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    rw [mkAndCached_decl_eq]
    rw [hr]
    rw [hl]
    apply Circuit.toAIGAux_le_size
    omega
    apply Circuit.toAIGAux_le_size
    apply Circuit.toAIGAux_le_size
    omega
  case or l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    rw [mkOrCached_decl_eq]
    rw [hr]
    rw [hl]
    apply Circuit.toAIGAux_le_size
    omega
    apply Circuit.toAIGAux_le_size
    apply Circuit.toAIGAux_le_size
    omega
  case xor l r hl hr =>
    simp only [Circuit.toAIGAux, Ref.cast_eq]
    rw [mkXorCached_decl_eq]
    rw [hr]
    rw [hl]
    apply Circuit.toAIGAux_le_size
    omega
    apply Circuit.toAIGAux_le_size
    apply Circuit.toAIGAux_le_size
    omega

def _root_.Circuit.toAIG [DecidableEq α] [Fintype α] [Hashable α]
    (c : Circuit α) : Entrypoint α :=
  (c.toAIGAux .empty).val

open Std Sat AIG


@[simp]
axiom _root_.Circuit.denote_toAIGAux_eq_eval [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α}
    {env : α → Bool}
    {aig : AIG α} : -- TODO: I need a theorem that says that toAIG *extends*.
    ⟦(c.toAIGAux aig).val.aig, (c.toAIGAux aig).val.ref, env⟧ = c.eval env

-- @[simp]
-- theorem _root_.Circuit.denote_toAIGAux_eq_eval [DecidableEq α] [Fintype α] [Hashable α]
--     {c : Circuit α}
--     {env : α → Bool}
--     {aig : AIG α} : -- TODO: I need a theorem that says that toAIG *extends*.
--     ⟦(c.toAIGAux aig).val.aig, (c.toAIGAux aig).val.ref, env⟧ = c.eval env := by
--   induction c generalizing env aig
--   case tru =>
--     simp [Circuit.toAIGAux]
--   case fals =>
--     simp [Circuit.toAIGAux]
--   case var negated v =>
--     simp [Circuit.toAIGAux]
--     rcases negated with rfl | rfl <;> simp
--   case and l r hl hr =>
--     rw [Circuit.toAIGAux]
--     rw [denote_mkAndCached]
--     simp only [Ref.cast_eq, denote_projected_entry, Circuit.eval]
--     rw [hr]
--     congr
--     -- TODO: write theorem in terms of any AIG entrypoint.
--     sorry
--   case or l r hl hr =>
--     -- TODO: write theorem in terms of any AIG entrypoint.
--     sorry
--   case xor l r hl hr =>
--     -- TODO: write theorem in terms of any AIG entrypoint.
--     sorry

/-- The denotations of the AIG and the circuit agree. -/
@[simp]
theorem _root_.Circuit.denote_toAIG_eq_eval [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α}
    {env : α → Bool} :
    Std.Sat.AIG.denote env c.toAIG = c.eval env := by
  apply c.denote_toAIGAux_eq_eval

/-- If the circuit is UNSAT, then the AIG is UNSAT. -/
theorem Circuit.eval_eq_false_iff_toAIG_unsat [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α} :
    (∀ env, c.eval env = false) ↔ c.toAIG.Unsat := by
  rw [Entrypoint.Unsat, UnsatAt]
  simp [← Circuit.denote_toAIG_eq_eval]

open Std Sat AIG Reflect in
/-- Verify the AIG by converting to CNF and checking the LRAT certificate against it. -/
def verifyAIG [DecidableEq α] [Hashable α] (x : Entrypoint α) (cert : String) : Bool :=
  let y := (Entrypoint.relabelNat x)
  let z := AIG.toCNF y
  Std.Tactic.BVDecide.Reflect.verifyCert z cert



open Std Tactic BVDecide Reflect AIG in
/--
This theorem tracks that Std.Sat.AIG.Entrypoint.relabelNat_unsat_iff does not need a [Nonempty α]
to preserve unsatisfiability.
@hargoniX uses [Nonempty α] to convert a partial inverse to the relabelling.
However, this is un-necessary: One can case split on `Nonempty α`, and:
- When it is nonempty, we can apply the relabelling directly to show unsatisfiability.
- When it is empty, we show that the relabelling preserves unsatisfiability
  by showing that the relabelling is a no-op.
- Alternative proof strategy: Implement a 'RelabelNat' that case splits on
  'NonEmpty α', and when it is empty, returns the original AIG.
-/

theorem relabelNat_unsat_iff₂  [DecidableEq α] [Hashable α]
{entry : Entrypoint α} :
    (entry.relabelNat).Unsat ↔ entry.Unsat:= by
  simp only [Entrypoint.Unsat, Entrypoint.relabelNat]
  rw [relabelNat_unsat_iff']

/--
info: Std.Sat.AIG.Entrypoint.relabelNat_unsat_iff {α : Type} [DecidableEq α] [Hashable α] {entry : Entrypoint α}
  [Nonempty α] : entry.relabelNat.Unsat ↔ entry.Unsat
-/
#guard_msgs in #check Entrypoint.relabelNat_unsat_iff

open Std Tactic Sat AIG Reflect BitVec in
/-- Verifying the AIG implies that the AIG is unsat at the entrypoint. -/
theorem verifyAIG_correct [DecidableEq α] [Fintype α] [Hashable α]
    {entry : Entrypoint α} {cert : String}
    (h : verifyAIG entry cert) :
    entry.Unsat := by
  rw [verifyAIG] at h
  rw [← relabelNat_unsat_iff₂]
  rw [← AIG.toCNF_equisat entry.relabelNat]
  apply Std.Tactic.BVDecide.Reflect.verifyCert_correct (cert := cert) _ h

/-- Verify the circuit by translating to AIG. -/
def verifyCircuit {α : Type} [DecidableEq α] [Fintype α] [Hashable α] (c : Circuit α)
  (cert : String) : Bool := verifyAIG c.toAIG cert

/- If circuit verification succeeds, then the circuit is unsat. -/
theorem always_false_of_verifyCircuit [DecidableEq α] [Fintype α] [Hashable α]
    {c : Circuit α} {cert : String}
    (h : verifyCircuit c cert) :
    c.always_false := by
  simp
  intros env
  simp [verifyCircuit] at h
  apply Circuit.eval_eq_false_iff_toAIG_unsat .. |>.mpr
  apply verifyAIG_correct h


/-!
Helpers to use `bv_decide` as a solver-in-the-loop for the reflection proof.
-/

def cadicalTimeoutSec : Nat := 1000

attribute [nospecialize] Circuit.toAIG
-- attribute [nospecialize] Std.Sat.AIG.Entrypoint.relabelNat'

open Std Sat AIG Tactic BVDecide Frontend in
-- @[nospecialize]
def checkCircuitUnsatAux [DecidableEq α] [Hashable α] [Fintype α]
    (c : Circuit α) : TermElabM (Option LratCert) := do
  let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
  IO.FS.withTempFile fun _ lratFile => do
    let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
    let entrypoint:= c.toAIG
    let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
    let cnf := toCNF entrypoint
    let out ← runExternal cnf cfg.solver cfg.lratPath
      (trimProofs := true)
      (timeout := cadicalTimeoutSec)
      (binaryProofs := true)
    match out with
    | .error _model => return .none
    | .ok cert => return .some cert


-- open Std Sat AIG Tactic BVDecide Frontend in
-- @[nospecialize]
-- def checkCircuitTautoAuxImpl
--     [DecidableEq α] [Hashable α] [Fintype α]
--     (c : Circuit α) : TermElabM (Option LratCert) := do
--   let cfg : BVDecideConfig := { timeout := cadicalTimeoutSec }
--   IO.FS.withTempFile fun _ lratFile => do
--     let cfg ← BVDecide.Frontend.TacticContext.new lratFile cfg
--     let c := ~~~ c -- we're checking TAUTO, so check that negation is UNSAT.
--     let entrypoint := c.toAIG
--     let ⟨entrypoint, _labelling⟩ := entrypoint.relabelNat'
--     let cnf := toCNF entrypoint
--     let out ← runExternal cnf cfg.solver cfg.lratPath
--       (trimProofs := true)
--       (timeout := cadicalTimeoutSec)
--       (binaryProofs := true)
--     match out with
--     | .error _model => return none
--     | .ok cert => return some cert

-- open Std Sat AIG Tactic BVDecide Frontend in
-- @[implemented_by checkCircuitTautoAuxImpl, nospecialize]
-- def checkCircuitTautoAux {α : Type}
--     [DecidableEq α] [Hashable α] [Fintype α]
--     (c : Circuit α) : TermElabM (Option LratCert) := do
--   return none

-- /--
-- An axiom that tracks that a theorem is true because of our currently unverified
-- 'decideIfZerosM' decision procedure.
-- -/
-- axiom decideIfZerosMAx {p : Prop} : p

/--
An inductive type representing the variables in the unrolled FSM circuit,
where we unroll for 'n' steps.
-/
structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable


namespace Inputs

def elim0 {α : Sort u} (i : Inputs ι 0) : α :=
  i.ix.elim0

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨i.ix, by omega⟩
  input := i.input

/-- casts bits in `[0..n)` to `[m-n..m)` by shifting the index. -/
def castShift (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨m - 1 - i.ix, by omega⟩
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

instance [Inhabited σ] : Inhabited (Vars σ ι n) where
  default := .state (default)

instance  [Inhabited ι] : Inhabited (Vars σ ι (n + 1)) where
  default := .inputs (Inputs.latest default)

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

def Vars.castLe {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state s => .state s
  | .inputs is => .inputs (is.castLe hnm)

def Vars.castShift {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state s => .state s
  | .inputs is => .inputs (is.castShift hnm)

/-- Relate boolean and bitstream environments. -/
structure EnvOutRelated {arity : Type _} {α : Type _}
    (envBool : Vars α arity n → Bool)
    (envBitstream : arity → BitStream) where
  envBool_inputs_mk_eq_envBitStream : ∀ (x : arity) (i : Nat) (hi: i < n),
    envBool (Vars.inputs (Inputs.mk ⟨i, by omega⟩ x)) = envBitstream x i


theorem EnvOutRelated.envBool_inputs_mk_castShift_eq_envBitStream
   (envBool : Vars α arity m → Bool)
   (envBitstream : arity → BitStream)
   (hEnvBitstream : EnvOutRelated envBool envBitstream)
   (hnm : n ≤ m) (x : arity) (i : Nat) (hi : i < n) :
   (envBool ((Vars.inputs (Inputs.mk ⟨i, by omega⟩ x : Inputs _ n) :  Vars _ _ n).castShift hnm))=
   envBitstream x (m - 1 - i) := by 
  rw [← hEnvBitstream.envBool_inputs_mk_eq_envBitStream]
  rfl


attribute [simp] EnvOutRelated.envBool_inputs_mk_eq_envBitStream

/-- Environment with no state variables. -/
def envBoolEmpty_of_envBitstream
   (envBitstream : arity → BitStream)
   (n : Nat) : Vars Empty arity (n + 1) → Bool :=
  fun x =>
    match x with
    | .state s => s.elim
    | .inputs (.mk a i) => envBitstream i a

/-- Environment with chosen state variables of the FSM. -/
def envBoolStart_of_envBitstream (p : FSM α)
   (envBitstream : arity → BitStream)
   (n : Nat) : Vars p.α arity (n + 1) → Bool :=
  fun x =>
    match x with
    | .state s => p.initCarry s
    | .inputs (.mk a i) => envBitstream i a

/-- Environment with chosen state variables of the FSM. -/
def envBool_of_envBitstream_of_state
   (envBitstream : arity → BitStream)
   (state : α → Bool)
   (n : Nat) : Vars α arity (n + 1) → Bool :=
  fun x =>
    match x with
    | .state s => state s
    | .inputs (.mk a i) => envBitstream i a

@[simp]
theorem envBool_of_envBitstream_of_state_eq₁ {arity : Type _} {α : Type _}
    (envBitstream : arity → BitStream) (state : α → Bool) (n : Nat)
    (s : α) :
    envBool_of_envBitstream_of_state envBitstream state n (.state s) = state s := rfl

@[simp]
theorem envBool_of_envBitstream_of_state_eq₂ {arity : Type _} {α : Type _}
    (envBitstream : arity → BitStream) (state : α → Bool) (n : Nat)
    (i : Inputs arity (n + 1)) :
    envBool_of_envBitstream_of_state envBitstream state n (.inputs i) =
    envBitstream i.input i.ix := rfl

def Bitstream_of_envBool
  (envBool : Vars α arity n → Bool) :
  (arity → BitStream) :=
  fun a =>
    fun k =>
      if hk : k < n
      then envBool (.inputs (Inputs.mk ⟨k, by omega⟩ a))
      else false

/-- make the init carry of the FSM from the envBool. -/
def initCarry_of_envBool {p : FSM α}
  (envBool : Vars p.α arity n → Bool) :
  p.α → Bool := fun a => envBool (.state a)

@[simp]
theorem EnvOutRelated_envBoolEmpty_of_envBitStream_of_self {arity : Type _}
    (envBitstream : arity → BitStream) :
    EnvOutRelated (envBoolEmpty_of_envBitstream envBitstream n) envBitstream := by
  constructor
  intros x i hi
  rw [envBoolEmpty_of_envBitstream]

@[simp]
theorem EnvOutRelated_envBoolStart_of_envBitStream_of_self {arity : Type _} {α : Type _}
    (p : FSM α) (envBitstream : arity → BitStream) :
    EnvOutRelated (envBoolStart_of_envBitstream p envBitstream n) envBitstream := by
  constructor
  intros x i hi
  rw [envBoolStart_of_envBitstream]

@[simp]
theorem EnvOutRelated_envBoolStart_ofenvBitstream_of_state_of_self
    {arity : Type _} {α : Type _}
    (envBitstream : arity → BitStream) (state : α → Bool) :
    EnvOutRelated (envBool_of_envBitstream_of_state envBitstream state n) envBitstream := by
  constructor
  intros x i hi
  rw [envBool_of_envBitstream_of_state]

@[simp]
theorem EnvOutRelated_self_Bitstream_of_envBool
    (envBool : Vars α arity n → Bool) :
    EnvOutRelated envBool (Bitstream_of_envBool envBool) := by
  constructor
  intros x i hi
  simp [Bitstream_of_envBool, hi]

-- structure StateCircuit {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) (iter : Nat) where ofFun ::
--   toFun : p.α →  Circuit (Vars p.α arity iter)

-- /-- Product initial state vector,
-- that sets the state to be the intial state as given by the FSM.. -/
-- def StateCircuit.zero {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) : StateCircuit p 0 where
--   toFun :=
--     fun a => Circuit.ofBool (p.initCarry a)

-- @[simp]
-- theorem StateCircuit.zero_eval {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} {a : p.α} (envBool : Vars p.α arity 0 → Bool) :
--     ((StateCircuit.zero p).toFun a).eval envBool = p.initCarry a := by
--   simp only [zero, Circuit.ofBool]
--   rcases h : p.initCarry a <;> simp [h]

-- /-- Product free state vector, that reads state from the input.. -/
-- def StateCircuit.id  {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) : StateCircuit p 0 where
--   toFun :=
--     fun a => Circuit.var true (Vars.state a)

-- @[simp]
-- theorem StateCircuit.eval_id {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} {a : p.α} {envBool : Vars p.α arity 0 → Bool} :
--     ((StateCircuit.id p).toFun a).eval envBool = (envBool (Vars.state a)) := by
--   simp only [id, Circuit.ofBool]
--   rcases h : p.initCarry a <;> simp [h]

-- /-- Make a circuit for one step of transition.  -/
-- def StateCircuit.delta  {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) : StateCircuit p 1 where
--   toFun :=
--     fun a =>
--       let x := StateCircuit.id p
--       x.toFun a |>.bind fun v =>
--         match v with
--         | .state s =>
--           let d := p.nextBitCirc (some s)
--           d.map fun w =>
--             match w with
--             | .inl a => Vars.state a
--             | .inr i => Vars.inputs (Inputs.mk 0 i)
--         | .inputs i => i.elim0

-- @[simp]
-- theorem StateCircuit.eval_delta {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} {a : p.α} (envBool : Vars p.α arity 1 → Bool)
--     (envBitstream : arity → BitStream)
--     (hEnvBitstream : EnvOutRelated envBool envBitstream)
--     :
--     ((StateCircuit.delta p).toFun a).eval envBool =
--     p.delta (fun s => envBool (Vars.state s)) envBitstream a
--       := by
--   simp only [delta, Fin.isValue, Circuit.eval_bind, eval_id, FSM.delta_eq_carryWith_one]
--   simp only [Fin.isValue, FSM.carryWith]
--   simp only [Fin.isValue, Circuit.eval_map]
--   congr
--   ext x
--   rcases x with state | x
--   · simp only [FSM.carry_zero, FSM.initCarry_changeInitCarry_eq, Sum.elim_inl]
--   · simp only [Fin.isValue, FSM.carry_zero, FSM.initCarry_changeInitCarry_eq, Sum.elim_inr]
--     apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream

-- /-- Allow state circuit to consume more inputs.  -/
-- def StateCircuit.castLe  {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity}
--     (cn : StateCircuit p n)
--     (hnm : n ≤ m) :  StateCircuit p m where
--   toFun := fun state =>
--     (cn.toFun state).map fun v => v.castLe hnm

-- @[simp]
-- theorem StateCircuit.toFun_castLe {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} {n m : Nat} (cn : StateCircuit p n) (hnm : n ≤ m) :
--     (cn.castLe hnm).toFun = (fun i => (cn.toFun i).map (fun v => v.castLe hnm)) := rfl

-- /-- Move inputs from [0..n) to [d..d+n). -/
-- def StateCircuit.translateInputs {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity}
--     (cn : StateCircuit p n)
--     (d : Nat) : StateCircuit p (d + n) where
--   toFun := fun state =>
--     (cn.toFun state).map fun v =>
--       match v with
--       | .state s => .state s
--       | .inputs i => .inputs (Inputs.mk ⟨i.ix + d, by omega⟩ i.input)

-- /-- Compose state circuits of 'n' steps and 'm' steps to get a circuit for 'n + m' steps. -/
-- def StateCircuit.compose {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity}
--     /- Circuit that runs for [0..n) steps. -/
--     (sFst : StateCircuit p n)
--     /- Circuit that runs for [n..n+m ] steps. -/
--     (sSnd : StateCircuit p m) :
--     StateCircuit p (n + m) where
--   toFun := fun state =>
--     ((sSnd.translateInputs n).toFun state).bind fun v =>
--       match v with
--       | .state s =>
--           (sFst.castLe (show n ≤ n + m by omega)).toFun s
--       | .inputs i => Circuit.var .true (.inputs i)

-- /-- How to evaluate composition of circuits. -/
-- theorem StateCircuit.eval_compose {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} {a : p.α} (envBool : Vars p.α arity (n + m) → Bool)
--     (sFst : StateCircuit p n) (sSnd : StateCircuit p m)
--     :
--     ((StateCircuit.compose sFst sSnd).toFun a).eval envBool =
--       (sSnd.toFun a).eval (fun v =>
--         match v with
--         | .state s => (sFst.toFun s).eval (fun v => envBool (v.castLe (by omega)))
--         | .inputs i => envBool <| .inputs <| Inputs.mk ⟨i.ix + n, by omega⟩ i.input
--       ):= by
--   simp only [compose]
--   simp only [toFun_castLe, Circuit.eval_bind]
--   simp only [translateInputs]
--   simp only [Circuit.eval_map]
--   congr 1
--   ext i
--   rcases i with s | i
--   · simp only
--     simp only [Circuit.eval_map]
--   · simp only [Circuit.eval, ↓reduceIte]

-- /-- Build the output circuit from the given state circuit. -/
-- def StateCircuit.toOutput {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity}
--     /- Circuit that runs for [0..n) steps. -/
--     (sc : StateCircuit p n)
--     /- Circuit that runs for [0..n+1] steps and produces an output. -/
--     : Circuit (Vars p.α arity (n + 1)) :=
--   (p.nextBitCirc none).bind fun v =>
--     match v with
--     | .inl s => (sc.castLe (by omega)).toFun s
--     | .inr i =>  Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ i))

-- theorem StateCircuit.eval_toOutput_eq_
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} (envBool : Vars p.α arity (n + 1) → Bool)
--     -- (envBitstream : arity → BitStream)
--     -- (hEnvBitstream : EnvOutRelated envBool envBitstream)
--     (sc : StateCircuit p n)
--     :
--     (sc.toOutput).eval envBool =
--     ((p.nextBitCirc none).eval (fun x =>
--       match x with
--       | .inl s => (sc.toFun s).eval (fun i => envBool <| i.castLe (by omega))
--       | .inr i => envBool <| Vars.inputs (Inputs.mk ⟨n, by omega⟩ i))) := by
--   simp only [toOutput, toFun_castLe]
--   simp only [Circuit.eval_bind]
--   congr
--   ext x
--   rcases x with s | i
--   · simp  [Circuit.eval_map]
--   · simp

-- @[simp]
-- theorem StateCircuit.eval_toOutput_eq
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     {p : FSM arity} (envBool : Vars p.α arity (n + 1) → Bool)
--     (sc : StateCircuit p n)
--     :
--     (sc.toOutput).eval envBool =
--     p.outputWith
--       (fun s => (sc.toFun s).eval (fun i => envBool <| i.castLe (by omega)))
--       (fun i => envBool <| Vars.inputs (Inputs.mk ⟨n, by omega⟩ i)) := by
--   simp only [toOutput, toFun_castLe]
--   simp only [Circuit.eval_bind]
--   congr
--   ext x
--   rcases x with s | i
--   · simp  [Circuit.eval_map]
--   · simp


-- /-- Build the circuit for n transitions.-/
-- def StateCircuit.deltaN  {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity)
--     (n : Nat) : StateCircuit p n :=
--   match n with
--   | 0 => StateCircuit.id p
--   | n' + 1 =>
--     let d := (StateCircuit.delta p)
--     let sn := StateCircuit.deltaN p n'
--     (d.compose sn).castLe (by omega)

-- @[simp]
-- theorem StateCircuit.eval_deltaN_eq {arity : Type _}
--   [DecidableEq arity]
--   [Fintype arity]
--   [Hashable arity]
--   {p : FSM arity} (envBool : Vars p.α arity n → Bool)
--   (envBitstream : arity → BitStream)
--   (hEnvBitstream : EnvOutRelated envBool envBitstream)
--   (s : p.α)
--   :
--   ((StateCircuit.deltaN p n).toFun s).eval envBool =
--     p.carryWith (fun s => envBool <| .state s) envBitstream n s := by
--   induction n
--   case zero =>
--     simp [StateCircuit.deltaN, StateCircuit.id, Circuit.eval_map]
--   sorry


-- /-- Make circuit that produces output for index 'i'. -/
-- def StateCircuit.deltaNOutput {arity : Type _}
--   [DecidableEq arity]
--   [Fintype arity]
--   [Hashable arity]
--   (p : FSM arity) (n : Nat) (i : Nat)  (hin : i ≤ n): (Circuit (Vars p.α arity (n+1))) :=
--   ((StateCircuit.deltaN p i).castLe (show i ≤ n by omega)).toOutput

-- @[simp]
-- theorem StateCircuit.eval_deltaNOutput_eq
--     {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n)
--     (envBool : Vars p.α arity (n + 1) → Bool)
--     (envBitstream : arity → BitStream)
--     (envInit : p.α → Bool)
--     (hEnvInit : envInit = initCarry_of_envBool envBool)
--     (hEnvBitstream : EnvOutRelated envBool envBitstream)
--     :
--     (deltaNOutput p n i hin).eval envBool = p.evalWith envInit envBitstream i := by
--   rw [deltaNOutput]
--   simp only [eval_toOutput_eq, toFun_castLe]
--   sorry


/-- Take the 'or' of many circuits.-/
def Circuit.bigOr {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.fals
  | c :: cs =>
    c ||| (Circuit.bigOr cs)

@[simp]
theorem Circuit.eval_bigOr_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = false ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = false) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

@[simp]
theorem Circuit.eval_bigOr_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = true ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = true) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

/-- Take the and of many circuits.-/
def Circuit.bigAnd {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.tru
  | c :: cs =>
    c &&& (Circuit.bigAnd cs)

@[simp]
theorem Circuit.eval_bigAnd_eq_true_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = true ↔
    (∀ (c : Circuit α), c ∈ cs → c.eval env = true) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp [bigAnd, ih]

@[simp]
theorem Circuit.eval_bigAnd_eq_false_iff
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigAnd cs).eval env = false ↔
    (∃ (c : Circuit α), c ∈ cs ∧ c.eval env = false) := by
  induction cs
  case nil => simp [bigAnd]
  case cons a as ih =>
    simp only [bigAnd, Circuit.eval.eq_4, Bool.and_eq_false_imp, ih, List.mem_cons,
      exists_eq_or_imp]
    by_cases h : a.eval env <;> simp [h, ih]

/--
Make the circuit that produces the state vector after 'n' iterations.
This needs 'n' bits of input.
-/
def mkRealStateVectorCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : p.α → Circuit (Vars Empty arity n) := fun s =>
  match n with
  | 0 => Circuit.ofBool (p.initCarry s)
  | n + 1 =>
    (p.nextBitCirc (some s)).bind fun v =>
      match v with
      | .inl s' => (mkRealStateVectorCircuit p n s').map fun w =>
        match w with
        | .state s'' => Vars.state s''
        | .inputs i => Vars.inputs (Inputs.mk (i.ix) i.input)
      | .inr a => Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ a))

theorem mkRealStateVectorCircuit_eval_eq {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) (s : p.α)
    (envBool : Vars Empty arity n → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
  (mkRealStateVectorCircuit p n s).eval envBool =
  p.carryWith (fun s => p.initCarry s) envBitstream n s := by
  induction n generalizing s
  case zero =>
    simp only [mkRealStateVectorCircuit, Circuit.ofBool, FSM.carryWith_zero_eq]
    rcases h : p.initCarry s <;> simp [h]
  case succ m hm =>
    simp only [mkRealStateVectorCircuit, Fin.coe_eq_castSucc, Circuit.eval_bind,
      FSM.carryWith_initCarry_eq_carry]
    simp only [FSM.carry, FSM.nextBit]
    congr
    ext x
    rcases x with a | i
    · simp only [Circuit.eval_map, Sum.elim_inl]
      rw [hm]
      · rfl
      · -- TODO: write this as a theorem that encapsuates that environments are related
        -- upon casting of the input.
        constructor
        intros x i hi
        simp only [Fin.castSucc_mk]
        apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
    · simp only [Circuit.eval, ↓reduceIte, Sum.elim_inr]
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream


/--
Make the circuit that produces the output value after 'n' iterations.
This needs 'n+1' bits of input.
-/
def mkEvalCircuit {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) : Circuit (Vars Empty arity (n+1)) :=
  p.nextBitCirc none |>.bind fun v =>
    match v with
    | .inl s => (mkRealStateVectorCircuit p n s).map fun w =>
      match w with
      | .state s' => Vars.state s'
      | .inputs i => Vars.inputs (Inputs.mk ⟨i.ix, by omega⟩ i.input)
    | .inr a => Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ a))

@[simp]
theorem eval_mkEvalCircuit_eq_false_iff
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars Empty arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    -- Make a safety circuit, that computes the evaluation of the FSM.
    (mkEvalCircuit p n).eval envBool =
      p.eval envBitstream n  := by
  simp [mkEvalCircuit]
  simp [Circuit.eval_bind]
  rw [FSM.eval, FSM.nextBit]
  simp
  congr
  ext x
  rcases x with a | i
  · simp [Circuit.eval_map]
    rw [mkRealStateVectorCircuit_eval_eq (envBitstream := envBitstream)]
    · simp
    · -- TODO: write this as a theorem that encapsulates that environments are related
      -- upon casting of the input.
      constructor
      intros x i hi
      simp only [Fin.castSucc_mk]
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
  · simp [initCarry_of_envBool]
    apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream

/--
info: 'ReflectVerif.BvDecide.eval_mkEvalCircuit_eq_false_iff' depends on axioms: [propext, Quot.sound]
-/
#guard_msgs in #print axioms eval_mkEvalCircuit_eq_false_iff


-- /-
-- Make the safety circuit at index 'i',
-- which runs the program at the initial state on the inputs.
-- See that this fixes the state to 'Empty'.
-- -/
-- def mkSafetyCircuitAuxElem {arity : Type _}
--   [DecidableEq arity]
--   [Fintype arity]
--   [Hashable arity]
--   (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n) : (Circuit (Vars Empty arity (n+1))) :=
--   (StateCircuit.deltaNOutput p n i (by omega)).bind fun v =>
--     match v with
--     | .state s => Circuit.ofBool <| p.initCarry s
--     | .inputs i => Circuit.var true (.inputs i)


-- @[simp]
-- theorem eval_mkSafetyCircuitAuxElem_eq_false_iff
--     {arity : Type _}
--     [DecidableEq arity]
--     [Fintype arity]
--     [Hashable arity]
--     (p : FSM arity) (n : Nat) (i : Nat) (hin : i ≤ n)
--     (envBool : Vars Empty arity (n + 1) → Bool)
--     (envBitstream : arity → BitStream)
--     (hEnvBitstream : EnvOutRelated envBool envBitstream) :
--     (mkEvalCircuit p n).eval envBool =
--     p.eval envBitstream n = false := by

/-- Make the list of safety circuits upto length 'n + 1'. -/
def mkSafetyCircuitAuxList {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) :
    List (Circuit (Vars Empty arity (n+1))) :=
  let ys := (List.range (n+1)).attach
  ys.map fun i =>
    (mkEvalCircuit p i.val).map (fun vs => vs.castLe (by
      have := i.property; simp at this; omega
    ))

/--
make the circuit that witnesses safety for (n+1) steps.
This builds the safety circuit for 'n+1' steps, and takes the 'or' of all of these.
-/
def mkSafetyCircuit {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars Empty arity (n+1)) :=
  Circuit.bigOr (mkSafetyCircuitAuxList p n)

/--
Evaluating the safety circuit is false iff
the bitstreams are false upto index 'n'.
-/
theorem eval_mkSafetyCircuit_eq_false_iff_ {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars Empty arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    (mkSafetyCircuit p n).eval envBool = false ↔
    (∀ (i : Nat), i ≤ n → p.eval envBitstream i = false) := by
  rw [mkSafetyCircuit]
  rw [Circuit.eval_bigOr_eq_false_iff]
  rw [mkSafetyCircuitAuxList]
  simp
  constructor
  · intros hc i hi
    specialize hc _ i (by omega) rfl
    simp [Circuit.eval_map] at hc
    rw [eval_mkEvalCircuit_eq_false_iff
      (envBitstream := envBitstream)
    ] at hc
    · apply hc
    · -- TODO: write this as a theorem that encapsulates that environments are related
      -- upon casting of the input.
      constructor
      intros x j hj
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
  · intros heval circ i hi hCirc
    subst hCirc
    simp [Circuit.eval_map]
    rw [eval_mkEvalCircuit_eq_false_iff]
    · apply heval
      omega
    · constructor
      intros x j hj
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream

/--
info: 'ReflectVerif.BvDecide.eval_mkSafetyCircuit_eq_false_iff_' depends on axioms: [propext, Quot.sound]
-/
#guard_msgs in #print axioms eval_mkSafetyCircuit_eq_false_iff_

/--
Evaluating the safety circuit is false iff
the bitstreams are false upto index 'n'.
-/
theorem eval_mkSafetyCircuit_eq_false_iff {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity) (n : Nat) :
    (∀ envBool, (mkSafetyCircuit p n).eval envBool = false) ↔
    (∀ envBitstream, ∀ (i : Nat), i ≤ n → p.eval envBitstream i = false) := by
  constructor
  · intros h envBitstream i  hi
    let envBool := envBoolEmpty_of_envBitstream envBitstream n
    specialize h envBool
    rw [eval_mkSafetyCircuit_eq_false_iff_
      (envBitstream := envBitstream)
    ] at h
    · apply h
      omega
    · simp [envBool]
  · intros h envBool
    rw [eval_mkSafetyCircuit_eq_false_iff_
      (envBitstream := Bitstream_of_envBool envBool)
    ]
    · intros i hi
      apply h (Bitstream_of_envBool envBool) i hi
    · simp

/--
info: 'ReflectVerif.BvDecide.eval_mkSafetyCircuit_eq_false_iff' depends on axioms: [propext, Quot.sound]
-/
#guard_msgs in #print axioms eval_mkSafetyCircuit_eq_false_iff

/-! ## Arbitrary State Vector Builder

This section builds a circuit that produces the state vector after 'n' iterations,
starting with a state vector that is given by the circuit itself.

-/
/--
Make the circuit that produces the state vector after 'n' iterations,
starting with a state vector that is given by the circuit itself.
-/
def mkStateVectorWithCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : p.α → Circuit (Vars p.α arity n) := fun s =>
  match n with
  | 0 => Circuit.var true (Vars.state s)
  | n + 1 =>
    (p.nextBitCirc (some s)).bind fun v =>
      match v with
      | .inl s' => (mkStateVectorWithCircuit p n s').map fun w =>
        match w with
        | .state s'' => Vars.state s''
        | .inputs i => Vars.inputs (Inputs.mk (i.ix) i.input)
      | .inr a => Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ a))

theorem eval_mkStateVectorWithCircuit_eq_carryWith {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat) (s : p.α)
    (envBool : Vars p.α arity n → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
  (mkStateVectorWithCircuit p n s).eval envBool =
  p.carryWith (fun s => envBool (Vars.state s)) envBitstream n s := by
  induction n generalizing s
  case zero =>
    simp only [mkStateVectorWithCircuit, Circuit.ofBool, FSM.carryWith_zero_eq]
    rcases h : envBool (Vars.state s) <;> simp [h]
  case succ m hm =>
    simp only [mkStateVectorWithCircuit, Fin.coe_eq_castSucc, Circuit.eval_bind,
      FSM.carryWith_initCarry_eq_carry]
    congr
    ext x
    rcases x with a | i
    · simp only [Circuit.eval_map, Sum.elim_inl]
      rw [hm]
      · rfl
      · -- Theorem: If the environments are related, then the evaluation of the circuit
        -- with the state vector is consistent with the evaluation of the FSM.
        constructor
        intros x i hi
        simp only [Fin.castSucc_mk]
        apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
    · simp only [Circuit.eval, ↓reduceIte, Sum.elim_inr]
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream

/-
Make the safety circuit at index 'i',
which runs the program at the initial state on the inputs.
See that this fixes the state to 'Empty'.
-/
def mkEvalWithCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : (Circuit (Vars p.α arity (n+1))) :=
  p.nextBitCirc none |>.bind fun v =>
    match v with
    | .inl s => (mkStateVectorWithCircuit p n s).map fun w =>
      match w with
      | .state s' => Vars.state s'
      | .inputs i => Vars.inputs (Inputs.mk ⟨i.ix, by omega⟩ i.input)
    | .inr a => Circuit.var true (Vars.inputs (Inputs.mk ⟨n, by omega⟩ a))

@[simp]
theorem eval_mkEvalWithCircuit_eq
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    (mkEvalWithCircuit p n).eval envBool =
    p.evalWith (fun s => envBool (.state s)) envBitstream n := by
  simp [mkEvalWithCircuit]
  simp [Circuit.eval_bind, Circuit.eval_map]
  rw [FSM.evalWith, FSM.eval, FSM.nextBit]
  simp
  congr
  ext x
  rcases x with a | i
  · simp [Circuit.eval_map, Sum.elim_inl]
    rw [eval_mkStateVectorWithCircuit_eq_carryWith]
    · rw [FSM.carryWith]
    · -- TODO extract out into generic theory.
      constructor
      intros x j hj
      simp only [Fin.castSucc_mk]
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
  · simp only [Circuit.eval_map, Sum.elim_inr]
    simp only [Circuit.eval, ↓reduceIte]
    apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream


def mkEvalWithNCircuitAuxList {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : List (Circuit (Vars p.α arity (n+1))) :=
  let ys := (List.range (n+1)).attach
  ys.map fun i =>
    (mkEvalWithCircuit p i.val).map (fun vs => vs.castLe (by
      have := i.property; simp at this; omega
    ))

def mkEvalWithNCircuit {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity (n+1)) :=
  Circuit.bigOr (mkEvalWithNCircuitAuxList p n)

@[simp]
theorem eval_mkEvalWithNCircuit_eq_false_iff
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    ((mkEvalWithNCircuit p n).eval envBool = false) ↔
    (∀ i < n + 1, p.evalWith (fun s => envBool (.state s)) envBitstream i = false) := by
  simp [mkEvalWithNCircuit, Circuit.eval_bigOr_eq_false_iff, mkEvalWithNCircuitAuxList]
  constructor
  · intros hc
    intros i hi
    specialize hc ?circ i (by omega) rfl
    simp [Circuit.eval_map] at hc
    rw [eval_mkEvalWithCircuit_eq (envBitstream := envBitstream)] at hc
    · apply hc
    · constructor
      intros x j hj
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
  · intros h c i hi hc
    subst hc
    rw [Circuit.eval_map]
    rw [eval_mkEvalWithCircuit_eq (envBitstream := envBitstream)]
    · rw [← h i]
      congr
      omega
    · constructor
      intros a k hk
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream


@[simp]
theorem eval_mkEvalWithNCircuit_eq_true_iff
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (n : Nat)
    (envBool : Vars p.α arity (n + 1) → Bool)
    (envBitstream : arity → BitStream)
    (hEnvBitstream : EnvOutRelated envBool envBitstream) :
    ((mkEvalWithNCircuit p n).eval envBool = true) ↔
    (∃ i < n + 1, p.evalWith (fun s => envBool (.state s)) envBitstream i = true) := by
    rw [show ((mkEvalWithNCircuit p n).eval envBool = true) =
        ¬ ((mkEvalWithNCircuit p n).eval envBool = false) by simp]
    rw [show ∃ i < n + 1, p.evalWith (fun s => envBool (.state s)) envBitstream i = true =
        ¬ (∀ i < n + 1, p.evalWith (fun s => envBool (.state s)) envBitstream i = false) by simp]
    apply Iff.not
    apply eval_mkEvalWithNCircuit_eq_false_iff (hEnvBitstream := hEnvBitstream)



def mkUnsatImpliesCircuit (lhs rhs : Circuit α) : Circuit α :=
  -- truth table of this circuit:
  -- lhs         |  rhs          | eval
  --   0         |  0            | 0
  --   0         |  1            | 1
  --   1         |  0            | 0
  --   1         |  1            | 0
  ~~~ lhs &&& rhs

@[simp]
theorem mkUnsatImpliesCircuit_eq_false_iff
    (env : α → Bool)
    (lhs rhs : Circuit α) :
    (mkUnsatImpliesCircuit lhs rhs).eval env = false ↔
    (Circuit.eval lhs env = false → Circuit.eval rhs env = false) := by
  rw [mkUnsatImpliesCircuit]
  simp

def mkIndHypCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity (n+2)) :=
  -- truth table of this circuit:
  -- safe upto n | safe upto n+1 | output
  --   0         |  0            | 0
  --   0         |  1            | 1
  --   1         |  0            | 0
  --   1         |  1            | 0
  mkUnsatImpliesCircuit
    ((mkEvalWithNCircuit p n).map (fun vs => vs.castLe (by omega)))
    (mkEvalWithNCircuit p (n + 1))

/-- induction hyp circuit. -/
theorem eval_mkIndHypCircuit_eq_false_iff_ {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat)
  {envBool : Vars p.α arity (n + 2) → Bool}
  {envBitstream : arity → BitStream}
  (hEnvBitstream : EnvOutRelated envBool envBitstream) :
  (mkIndHypCircuit p n).eval envBool = false ↔
  ((∀ i < n + 1, p.evalWith (fun s => envBool (.state s)) envBitstream i = false) →
   (∀ i < n + 2, p.evalWith (fun s => envBool (.state s)) envBitstream i = false)) := by
  rw [mkIndHypCircuit]
  rw [mkUnsatImpliesCircuit_eq_false_iff]
  rw [Circuit.eval_map]
  constructor
  · intros h hc j hj
    rw [eval_mkEvalWithNCircuit_eq_false_iff (hEnvBitstream := hEnvBitstream)] at h
    rw [eval_mkEvalWithNCircuit_eq_false_iff (envBitstream := envBitstream)] at h
    · apply h
      intros k hk
      apply hc
      omega
      omega
    · constructor
      intros a k hk
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream
  · intros h hlhs
    rw [eval_mkEvalWithNCircuit_eq_false_iff (hEnvBitstream := hEnvBitstream)]
    rw [eval_mkEvalWithNCircuit_eq_false_iff (envBitstream := envBitstream)] at hlhs
    · intros i hi
      apply h
      intros j hj
      rw [← hlhs j (by omega)]
      · congr
      · omega
    · constructor
      intros a k hk
      apply hEnvBitstream.envBool_inputs_mk_eq_envBitStream

@[simp]
theorem eval_mkIndHypCircuit_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  (∀ envBool, (mkIndHypCircuit p n).eval envBool = false) ↔
  (∀ (state : p.α → Bool) (envBitstream : arity → BitStream),
    ((∀ i ≤ n, p.evalWith state envBitstream i = false) →
     (∀ i ≤ n + 1, p.evalWith state envBitstream i = false))) := by
  constructor
  · intros h
    intros state envBitstream hlhs j hj
    let envBool := envBool_of_envBitstream_of_state envBitstream state (n + 1)
    specialize h envBool
    rw [eval_mkIndHypCircuit_eq_false_iff_] at h
    · apply h
      · intros k hk
        apply hlhs
        omega
      · omega
    · simp [envBool]
  · intros h
    intros envBool
    rw [eval_mkIndHypCircuit_eq_false_iff_]
    let envBitstream := Bitstream_of_envBool envBool
    · intros hCirc j hj
      apply h (state := fun s => envBool (.state s)) envBitstream
      intros k hk
      apply hCirc
      · omega
      · omega
    · simp

@[simp]
theorem Inputs.castLe_eq_self {α : Type _} {n : Nat} (i : Inputs α n) (h : n ≤ n) :
    i.castLe h = i := by
  simp [Inputs.castLe]

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_eq_self {α : Type _} {n : Nat} (v : Vars α σ n) (h : n ≤ n) :
    v.castLe h = v := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]

/-- induction principle with a uniform bound 'bound' in place. -/
@[elab_as_elim]
theorem ind_principle₂  {motive : Nat → Prop} (bound : Nat)
  (hBase : ∀ i ≤ bound, motive i)
  (hInd : ∀ (i : Nat),
    bound < i →
    ((∀ (k : Nat), k < bound → motive (i - k - 1)) → motive i)) :
  ∀ k, motive k := by
  intros k
  induction k using Nat.strong_induction_on
  case h k ihk =>
    by_cases hK : k ≤ bound
    · apply hBase
      omega
    · have : ∃ δ, k = δ + (bound) := by exists (k - (bound)); omega
      obtain ⟨δ, hδ⟩ := this
      subst hδ
      apply hInd
      omega
      intros ε  hε
      apply ihk
      omega

  theorem eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false {n : Nat}
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity)
    (hs : (mkSafetyCircuit p n).always_false)
    (hind : (mkIndHypCircuit p n).always_false) :
    ∀ (envBitstream : arity → BitStream) (i : Nat), p.eval envBitstream i = false := by
  intros envBitstream i
  simp [eval_mkSafetyCircuit_eq_false_iff] at hs
  simp [eval_mkIndHypCircuit_eq_false_iff] at hind
  rw [FSM.eval_eq_evalWith_initCarry]
  induction i using Nat.strong_induction_on
  case h i hStrongI =>
    induction i using ind_principle₂ n
    case hBase i hi =>
      apply hs
      omega
    case hInd j hjLt hjInd =>
      rw [show j = (j - (n + 1)) + (n + 1) by omega]
      rw [FSM.evalWith_add_eq_evalWith_carryWith]
      apply hind
      · intros i hi
        rw [← FSM.evalWith_add_eq_evalWith_carryWith]
        rw [show j - (n + 1)  + i = j - (n + 1 - i) by omega]
        rw [show j - (n + 1 - i) = j - ((n - i)) - 1 by omega]
        by_cases hi : i = 0
        · subst hi
          simp
          apply hStrongI
          omega
        · apply hjInd
          · omega
          · intros k hk; apply hStrongI; omega
      · omega

/--
info: 'ReflectVerif.BvDecide.eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false

/-- Version that is better suited to proving. -/
theorem eval_eq_false_of_verifyAIG_eq_of_verifyAIG_eq
    {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    {p : FSM arity}
    (sCert : BVDecide.Frontend.LratCert)
    (hs : verifyCircuit (mkSafetyCircuit p n) sCert = true)
    (indCert : BVDecide.Frontend.LratCert)
    (hind : verifyCircuit (mkIndHypCircuit p n) indCert = true) :
    ∀ env i, p.eval env i = false := by
  apply eval_eq_false_of_mkIndHypCircuit_false_of_mkSafetyCircuit_false (n := n)
  · apply always_false_of_verifyCircuit
    exact hs
  · apply always_false_of_verifyCircuit
    exact hind

/-- Prove that predicate is true iff the cerritificates check out. -/
theorem _root_.Predicate.denote_of_verifyAIG_of_verifyAIG
    {w : Nat}
    {vars : List (BitVec w)}
    (p : Predicate)
    (n : Nat)
    (sCert : BVDecide.Frontend.LratCert)
    (hs : verifyCircuit (mkSafetyCircuit (predicateEvalEqFSM p).toFSM n) sCert = true)
    (indCert : BVDecide.Frontend.LratCert)
    (hind : verifyCircuit (mkIndHypCircuit (predicateEvalEqFSM p).toFSM n) indCert = true) :
    p.denote w vars := by
  apply Predicate.denote_of_eval
  rw [← Predicate.evalFin_eq_eval p
    (varsList := (List.map BitStream.ofBitVec vars))
    (varsFin := fun i => (List.map BitStream.ofBitVec vars).getD i default)]
  · rw [(predicateEvalEqFSM p).good]
    apply eval_eq_false_of_verifyAIG_eq_of_verifyAIG_eq
      (n := n) (sCert := sCert) (indCert := indCert) (hs := hs) (hind := hind)
  · intros i
    simp

inductive DecideIfZerosOutput
/-- Safety property fails at this iteration. -/
| safetyFailure (iter : Nat)
/-- Was unable to establish invariant even at these many iterations. -/
| exhaustedIterations (numIters : Nat)
/-- we have proven both the safety and inductive invariant property. -/
| proven (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert) (indCert : BVDecide.Frontend.LratCert)

namespace DecideIfZerosOutput
def isSuccess : DecideIfZerosOutput → Bool
  | .safetyFailure _ => false
  | .exhaustedIterations _ => false
  | .proven .. => true
end DecideIfZerosOutput


@[nospecialize]
partial def decideIfZerosAuxVerified {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (fsm : FSM arity) :
    TermElabM (DecideIfZerosOutput) := do
  trace[Bits.FastVerif] s!"K-induction (iter={iter})"
  if iter ≥ maxIter && maxIter != 0 then
    throwError s!"ran out of iterations, quitting"
    return .exhaustedIterations maxIter
  let tStart ← IO.monoMsNow
  let cSafety : Circuit (Vars Empty arity (iter+1)) := mkSafetyCircuit fsm iter
  let tEnd ← IO.monoMsNow
  let tElapsedSec := (tEnd - tStart) / 1000
  trace[Bits.FastVerif] m!"Built safety circuit in '{tElapsedSec}s'"

  let formatα : fsm.α → Format := fun s => "s" ++ formatDecEqFinset s
  let formatEmpty : Empty → Format := fun e => e.elim
  let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
  trace[Bits.FastVerif] m!"safety circuit: {formatCircuit (Vars.format formatEmpty formatArity) cSafety}"
  let tStart ← IO.monoMsNow
  let safetyCert? ← checkCircuitUnsatAux cSafety
  let tEnd ← IO.monoMsNow
  let tElapsedSec := (tEnd - tStart) / 1000
  trace[Bits.FastVerif] m!"Checked safety property in {tElapsedSec} seconds."
  match safetyCert? with
  | .none =>
    trace[Bits.FastVerif] s!"Safety property failed on initial state."
    return .safetyFailure iter
  | .some safetyCert =>
    trace[Bits.FastVerif] s!"Safety property succeeded on initial state. Building induction circuit..."

    let tStart ← IO.monoMsNow
    let cIndHyp := mkIndHypCircuit fsm iter
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.FastVerif] m!"Built induction circuit in '{tElapsedSec}s'"

    let tStart ← IO.monoMsNow
    trace[Bits.FastVerif] m!"induction circuit: {formatCircuit (Vars.format formatα formatArity) cIndHyp}"
    -- let le : Bool := sorry
    let indCert? ← checkCircuitUnsatAux cIndHyp
    let tEnd ← IO.monoMsNow
    let tElapsedSec := (tEnd - tStart) / 1000
    trace[Bits.FastVerif] s!"Checked inductive invariant in '{tElapsedSec}s'."
    match indCert? with
    | .some indCert =>
      trace[Bits.FastVerif] s!"Inductive invariant established."
      return .proven iter safetyCert indCert
    | .none =>
      trace[Bits.FastVerif] s!"Unable to establish inductive invariant. Trying next iteration ({iter+1})..."
      decideIfZerosAuxVerified (iter + 1) maxIter fsm

@[nospecialize]
def _root_.FSM.decideIfZerosVerified  {arity : Type _} [DecidableEq arity]  [Fintype arity] [Hashable arity]
   (fsm : FSM arity) (maxIter : Nat) : TermElabM DecideIfZerosOutput :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `trace.Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    decideIfZerosAuxVerified 0 maxIter fsm

end BvDecide

end ReflectVerif
