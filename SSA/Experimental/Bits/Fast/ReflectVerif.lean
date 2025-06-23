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

open Fin.NatCast

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
  | .fals => ⟨⟨aig, aig.mkConstCached false⟩, by rfl⟩
  | .tru => ⟨⟨aig, aig.mkConstCached true⟩, by rfl⟩
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
    omega
  case fals =>
    simp [Circuit.toAIGAux]
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
  case fals =>
    simp [Circuit.toAIGAux]
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
info: Std.Sat.AIG.Entrypoint.relabelNat_unsat_iff {α : Type} [DecidableEq α] [Hashable α] {entry : Entrypoint α} :
  entry.relabelNat.Unsat ↔ entry.Unsat
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


/--
An inductive type representing the variables in the unrolled FSM circuit,
where we unroll for 'n' steps.
-/
structure Inputs (ι : Type) (n : Nat) : Type  where
  ix : Fin n
  input : ι
deriving DecidableEq, Hashable


namespace Inputs

def elimEmpty {α : Sort u} (i : Inputs Empty i) : α :=
  i.input.elim

def elim0 {α : Sort u} (i : Inputs ι 0) : α :=
  i.ix.elim0

def latest (i : ι) : Inputs ι (n+1) where
  ix := ⟨n, by omega⟩
  input := i

def castLe (i : Inputs ι n) (hn : n ≤ m) : Inputs ι m where
  ix := ⟨i.ix, by omega⟩
  input := i.input

@[simp]
theorem castLe_eq_self {α : Type _} {n : Nat} (i : Inputs α n) (h : n ≤ n) :
    i.castLe h = i := by
  simp [Inputs.castLe]

@[simp]
theorem castLe_castLe_eq_castLe {α : Type _} {p q r : Nat}
  (i : Inputs α p) (h : p ≤ q) (h' : q ≤ r) :
    (i.castLe h).castLe h' = i.castLe (by omega) := by
  simp [Inputs.castLe]

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

-- at 0:
-- + free s0.

-- at 1:
-- + free s0
-- --- x ---
-- + o0 = evalWith(s0, i0).
-- + s1 = carryWith(s0, i0)
-- --- x ---

-- at 2:
-- + free s0
-- --- x ---
-- + o0 = evalWith(s0, i0).
-- + s1 = carryWith(s0, i0)
-- --- x ---
-- + o1 = evalWith(s1, i1).
-- + s2 = carryWith(s1, i1)

inductive Vars (σ : Type) (ι : Type) (n : Nat)
| state (s : Inputs σ (n + 1))
| inputs (is : Inputs ι n)
| outputs (os : Fin n) -- there is one output bit for each step.
deriving DecidableEq, Hashable

/--
A state variable for the initial state.
-/
def Vars.state0 (s : σ) {n : Nat} : Vars σ ι n :=
  .state (Inputs.mk ⟨0, by omega⟩ s)

def Vars.stateN (s : σ) (i : Nat) {n : Nat} (hin : i ≤ n := by omega) : Vars σ ι n :=
  .state (Inputs.mk ⟨i, by omega⟩ s)

def Vars.inputN (inp : ι) (k : Nat) {n : Nat} (hkn : k < n := by omega) : Vars σ ι n :=
  .inputs (Inputs.mk ⟨k, by omega⟩ inp)


instance [Inhabited σ] : Inhabited (Vars σ ι n) where
  default := .state (Inputs.mk ⟨0, by omega⟩ default)

instance  [Inhabited ι] : Inhabited (Vars σ ι (n + 1)) where
  default := .inputs (Inputs.latest default)

instance [DecidableEq σ] [DecidableEq ι] [Fintype σ] [Fintype ι] : Fintype (Vars σ ι n) where
  elems :=
    let ss : Finset (Inputs σ (n + 1)) := Finset.univ
    let ss : Finset (Vars σ ι n) := ss.map ⟨Vars.state, by intros s s'; simp⟩

    let ii : Finset (Inputs ι n) := Finset.univ
    let ii : Finset (Vars σ ι n) := ii.map ⟨Vars.inputs, by intros ii ii'; simp⟩

    let oo : Finset (Fin n) := Finset.univ
    let oo : Finset (Vars σ ι n) := oo.map ⟨Vars.outputs, by intros o o'; simp⟩

    ss ∪ ii ∪ oo
  complete := by
    intros x
    simp
    rcases x with s | i  <;> simp

def Vars.format (fσ : σ → Format) (fι : ι → Format) {n : Nat} (v : Vars σ ι n) : Format :=
  match v with
  | .state ss => ss.format fσ
  | .inputs is => is.format fι
  | .outputs os => f!"{os}"

def Vars.castLe {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state ss => .state (ss.castLe (by omega))
  | .inputs is => .inputs (is.castLe hnm)
  | .outputs os =>
    .outputs (os.castLE (by omega))

def Vars.castShift {n m : Nat} (v : Vars σ ι n) (hnm : n ≤ m) : Vars σ ι m :=
  match v with
  | .state ss => .state (ss.castShift (by omega))
  | .inputs is => .inputs (is.castShift hnm)
  | .outputs os =>
    .outputs ⟨os.val + (m - n), by omega⟩

-- @[simp]
-- theorem Vars.castLe_state {n m : Nat} (s : σ) (hnm : n ≤ m) :
--    (Vars.state s : Vars σ ι n).castLe hnm = Vars.state s := by rfl

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_eq_self {α : Type _} {n : Nat} (v : Vars α σ n) (h : n ≤ n) :
    v.castLe h = v := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]
  · simp [Vars.castLe]

/-- casting to the same width equals vars-/
@[simp]
theorem Vars.castLe_castLe_eq_castLe_self {α : Type _} {p q r : Nat}
  (v : Vars α σ p) (h : p ≤ q) (h' : q ≤ r) :
    (v.castLe h).castLe h' = v.castLe (by omega) := by
  rcases v with x | i
  · simp [Vars.castLe]
  · simp [Vars.castLe]
  · simp [Vars.castLe]


/-- Relate boolean and bitstream environments. -/
structure EnvSimEnvBitstream {arity : Type _} {α : Type _}
    (envBool : Vars α arity n → Bool)
    (envBitstream : arity → BitStream) where
  envBool_inputs_mk_eq_envBitStream : ∀ (x : arity) (i : Nat) (hi: i < n),
    envBool (Vars.inputs (Inputs.mk ⟨i, by omega⟩ x)) = envBitstream x i


theorem EnvSimEnvBitstream.envBool_inputs_mk_castShift_eq_envBitStream
   (envBool : Vars α arity m → Bool)
   (envBitstream : arity → BitStream)
   (hEnvBitstream : EnvSimEnvBitstream envBool envBitstream)
   (hnm : n ≤ m) (x : arity) (i : Nat) (hi : i < n) :
   (envBool ((Vars.inputs (Inputs.mk ⟨i, by omega⟩ x : Inputs _ n) :  Vars _ _ n).castShift hnm))=
   envBitstream x (m - 1 - i) := by
  rw [← hEnvBitstream.envBool_inputs_mk_eq_envBitStream]
  rfl

attribute [simp] EnvSimEnvBitstream.envBool_inputs_mk_eq_envBitStream

/-- Take the 'or' of many circuits.-/
def Circuit.bigOr {α : Type _}
    (cs : List (Circuit α)) : Circuit α :=
  match cs with
  | [] => Circuit.fals
  | c :: cs =>
    c ||| (Circuit.bigOr cs)

@[simp]
theorem Circuit.bigOr_nil_eq {α : Type _} :
    Circuit.bigOr (α := α) [] = Circuit.fals := by
  simp [bigOr]

@[simp]
theorem Circuit.bigOr_cons_eq {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Circuit.bigOr (c :: cs) = c ||| Circuit.bigOr cs := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]


/-- append to the bigOr list is equivalent to a circuit
that is the bigOr of the circuit and the |||
-/
theorem Circuit.bigOr_append_equiv_or_bigOr {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Circuit.Equiv (Circuit.bigOr (cs ++ [c])) (c ||| Circuit.bigOr cs) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]
    ext env
    have := Circuit.eval_eq_of_Equiv ih
    simp
    rw [this]
    simp [Circuit.eval_or]
    rcases (a.eval env) <;> simp
-- bigOr [a, b]
-- = a ||| (bigOr [b])
-- = a ||| (b ||| fals)

theorem Circuit.bigOr_append_equiv_bigOr_cons {α : Type _}
    (c : Circuit α) (cs : List (Circuit α)) :
    Circuit.Equiv (Circuit.bigOr (cs ++ [c])) (Circuit.bigOr (c :: cs)) := by
  rw [Circuit.bigOr_cons_eq]
  apply Circuit.Equiv_trans
  · apply Circuit.bigOr_append_equiv_or_bigOr
  · apply Circuit.Equiv_refl

theorem Circuit.eval_bigOr_eq_decide
    (cs : List (Circuit α)) (env : α → Bool):
    (Circuit.bigOr cs).eval env = decide (∃ c ∈ cs, c.eval env = true) := by
  induction cs
  case nil => simp [bigOr]
  case cons a as ih =>
    simp [bigOr, ih]

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



structure CircuitStats where
  iter : Nat := 0
  size : Nat := 0

deriving Repr, Inhabited, DecidableEq, Hashable



/--
Make the funtion that for a given state 's', computes
`states[n+1][s] = carry[s](states[n][:], inputs[n])`.
--/
def mkCarryAssignCircuitNAux {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (s : p.α) (n : Nat) : Circuit (Vars p.α arity (n + 1)) :=
    (p.nextBitCirc (some s)).map fun v =>
      match v with
        | .inl t => Vars.stateN t n
        | .inr i => Vars.inputN i n

/--
The MkcarryAssign circuit is false iff
p.nextBitCirc evaluates to false on the given environment.
-/
theorem mkCarryAssignCircuitNAux_eval_eq_ {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (s : p.α) (n : Nat)
    {env : Vars p.α arity (n + 1) → Bool}
    {env' : p.α ⊕ arity → Bool}
    (hEnvState : ∀ (s : p.α), env (Vars.stateN s n) = env' (Sum.inl s))
    (hEnvInput : ∀ (i : arity), env (Vars.inputN i n) = env' (Sum.inr i)) :
    ((mkCarryAssignCircuitNAux p s n).eval env) = ((p.nextBitCirc (some s)).eval env') := by
  rw [mkCarryAssignCircuitNAux]
  rw [Circuit.eval_map]
  congr
  ext x
  rcases x with x | x
  · simp [hEnvState]
  · simp [hEnvInput]
/--
The MkcarryAssign circuit is false iff
p.nextBitCirc evaluates to false on the given environment.
-/
@[simp]
theorem mkCarryAssignCircuitNAux_eval_eq {arity : Type _}
    [DecidableEq arity]
    [Fintype arity]
    [Hashable arity]
    (p : FSM arity) (s : p.α) (n : Nat)
    {env : Vars p.α arity (n + 1) → Bool} :
    ((mkCarryAssignCircuitNAux p s n).eval env) = ((p.nextBitCirc (some s)).eval
      (fun x => match x with | .inl x => env (Vars.stateN x n) | .inr x => env (Vars.inputN x n))) := by
  rw [mkCarryAssignCircuitNAux]
  rw [Circuit.eval_map]
  congr
  ext x
  rcases x with x | x <;> simp

/--
Make the circuit that assigns the carry state:
  `states[n+1][:] = carry[:](states[n][:], inputs[n][:])`.
-/
def mkCarryAssignCircuitN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
  let carrys := FinEnum.toList p.α |>.map fun s =>
    -- | set the variable at states[n+1] = carry(states[n], inputs[n])
    Circuit.xor
      (mkCarryAssignCircuitNAux p s n)
      (Circuit.var true <| Vars.stateN s (n + 1))
  Circuit.bigOr carrys

@[simp]
theorem eval_mkCarryAssignCircuitN_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat)
  {env : Vars p.α arity (n + 1) → Bool} :
  ((mkCarryAssignCircuitN p n).eval env = false) ↔
    (∀ (s : p.α), env (Vars.stateN s (n + 1)) = (mkCarryAssignCircuitNAux p s n).eval env) := by
  rw [mkCarryAssignCircuitN]
  simp
  constructor
  · intros h s
    specialize h s
    rw [← h]
  · intros h s
    specialize h s
    rw [← h]

/--
Make the circuit that assigns `states[i][:] = carry(states[i-1][:], inputs[i-1][:])`
for all `i ≤ n`.
-/
def mkCarryAssignCircuitLeN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
    let ixs := List.range (n + 1) |>.attach
    let circs := ixs.map fun ⟨i, hi⟩ =>
      mkCarryAssignCircuitN p i |>.map (fun v => v.castLe (by simp at hi; omega))
    Circuit.bigOr circs

@[simp]
theorem mkCarryAssignCircuitLeN_eq_false_iff {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity] (p : FSM arity) (n : Nat)
  (env : Vars p.α arity (n + 1) → Bool) :
  ((mkCarryAssignCircuitLeN p n).eval env = false) ↔
  (∀ (s : p.α) (i : Nat), (hi : i < n + 1) →
    env (Vars.stateN s (i + 1)) =
     ((mkCarryAssignCircuitNAux p s i).map (fun v => v.castLe (by omega))).eval env) := by
  rw [mkCarryAssignCircuitLeN]
  simp only [Circuit.eval_bigOr_eq_false_iff, List.mem_map, List.mem_attach, true_and,
    Subtype.exists, List.mem_range, forall_exists_index]
  constructor
  · intros h s i hi
    specialize h ?c i (by omega) rfl
    simp only [Circuit.eval_map, eval_mkCarryAssignCircuitN_eq_false_iff,
      mkCarryAssignCircuitNAux_eval_eq] at h
    simp only [Circuit.eval_map, mkCarryAssignCircuitNAux_eval_eq]
    apply h
  · intros h c i hi hc
    subst hc
    simp only [Circuit.eval_map, eval_mkCarryAssignCircuitN_eq_false_iff,
      mkCarryAssignCircuitNAux_eval_eq]
    intros s
    specialize h s i hi
    simp only [Circuit.eval_map, mkCarryAssignCircuitNAux_eval_eq] at h
    apply h

/--
Make the circuit that assigns `states[0][s] = initCarry[s]`.
-/
def mkInitCarryAssignCircuitAux {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (s : p.α):
  Circuit (Vars p.α arity 0) :=
    Circuit.xor
      (Circuit.ofBool (p.initCarry s))
      (Circuit.var true <| Vars.stateN s 0)

theorem mkInitCarryAssignCircuitAux_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (s : p.α)
  {env : Vars p.α arity 0 → Bool}:
  ((mkInitCarryAssignCircuitAux p s).eval env = false) ↔
  (p.initCarry s = env (Vars.stateN s 0)) := by
  rw [mkInitCarryAssignCircuitAux]
  simp
  rcases hx : p.initCarry s
  · simp
  · simp

theorem mkInitCarryAssignCircuitAux_eq_decide {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (s : p.α)
  {env : Vars p.α arity 0 → Bool} :
  ((mkInitCarryAssignCircuitAux p s).eval env) = ! decide (p.initCarry s = env (Vars.stateN s 0)) := by
  rw [mkInitCarryAssignCircuitAux]
  simp
  rcases hx : p.initCarry s
  · simp
  · simp

/--
Make the circuit that assigns `states[0][:] = initCarry[:]`.
-/
def mkInitCarryAssignCircuit {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) :
  Circuit (Vars p.α arity 0) :=
    let carrys := FinEnum.toList p.α |>.map (mkInitCarryAssignCircuitAux p)
    Circuit.bigOr carrys

theorem mkInitCarryAssignCircuit_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity)
  {env : Vars p.α arity 0 → Bool} :
  (mkInitCarryAssignCircuit p).eval env = false ↔
  (∀ (s : p.α), p.initCarry s = env (Vars.stateN s 0)) := by
  rw [mkInitCarryAssignCircuit]
  simp [mkInitCarryAssignCircuitAux_eq_false_iff]

/--
Make a circuit that computes `out(states[n][:], inputs[n][:])`.
-/
def mkOutputAssignCircuitNAux {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity (n + 1)) :=
    (p.nextBitCirc none).map fun v =>
      match v with
        | .inl s' => Vars.stateN s' n
        | .inr i => Vars.inputN i n

/-- Make a circuit that assigns
`out[n] = out(states[n][:], inputs[n][:])`.
-/
def mkOutputAssignCircuitN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
    Circuit.xor
      (mkOutputAssignCircuitNAux p n)
      (Circuit.var true <| Vars.outputs ⟨n, by omega⟩)


def mkOutputAssignCircuitLeN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
    let ixs := List.range (n + 1) |>.attach
    let circs := ixs.map fun ⟨i, hi⟩ =>
      mkOutputAssignCircuitN p i |>.map (fun v => v.castLe (by simp at hi; omega))
    Circuit.bigOr circs


/--
Make a circuit that checks `out[n] = fals`.
-/
def mkOutEqZeroCircuitN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
    -- | f f f
    -- | t t f
    Circuit.xor
      (Circuit.ofBool false)
      (Circuit.var true <| Vars.outputs ⟨n, by omega⟩)


/--
Make a circuit that checks `out[n] = fals` for all `i ≤ n`
-/
def mkOutEqZeroCircuitLeN {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) :
  Circuit (Vars p.α arity (n + 1)) :=
    let ixs := List.range (n + 1) |>.attach
    let circs := ixs.map fun ⟨i, hi⟩ =>
      mkOutEqZeroCircuitN p i |>.map (fun v => v.castLe (by simp at hi; omega))
    Circuit.bigOr circs

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

/-- Make a circuit that checks if two states are disequal. -/
def mkStateNeqCircuit
  {arity : Type _} {i : Nat}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (s t : p.α → Circuit (Vars p.α arity i)) : Circuit (Vars p.α arity i) :=
  Circuit.bigAnd <| FinEnum.toList p.α |>.map fun a => ~~~ (s a) ^^^ (t a)


/-- if the state circuit is false, then the states are equal under all evaluations. -/
@[simp]
theorem mkStateNeqCircuit_eq_false_iff {arity : Type _} {i : Nat}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (s t : p.α → Circuit (Vars p.α arity i)) :
  (∀ envBool, (mkStateNeqCircuit p s t).eval envBool = false) ↔
  (∀ (envBool : Vars p.α arity i → Bool), ∃ (a : p.α), (s a).eval envBool ≠ (t a).eval envBool) := by
  simp [mkStateNeqCircuit, Circuit.eval_bigAnd_eq_false_iff]

/-- if the stateNeq circuit is false at a current environment,
then the states disagree at this environment. -/
@[simp]
theorem mkStateNeqCircuit_eq_false_iff₂  {arity : Type _} {i : Nat}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (s t : p.α → Circuit (Vars p.α arity i))
  (envBool : Vars p.α arity i → Bool) :
  ((mkStateNeqCircuit p s t).eval envBool = false) ↔
  ∃ (a : p.α), (s a).eval envBool ≠ (t a).eval envBool := by
  simp [mkStateNeqCircuit, Circuit.eval_bigAnd_eq_false_iff]

/--
Make all pairs of indices (i, j) such that 0 ≤ i < j ≤ n
-/
def mkLowerTriangularPairs (n : Nat) : List (Nat × Nat) :=
  let xs := List.range (n + 1) |>.attach
  xs.flatMap fun i =>
    let ys := List.range i.val |>.attach
    ys.map fun j => (j.val, i.val)


@[simp]
theorem mem_mkLowerTriangularPairs {n : Nat} (i j : Nat) :
  (i, j) ∈ mkLowerTriangularPairs n ↔
  (i < j ∧ j ≤ n) := by
  simp [mkLowerTriangularPairs]
  omega


/--
make the circuit that says that the state at index 'n' is disequal from all states [0..n)
-/
def mkStateUniqueCircuitN {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity n) :=
  let sn : p.α → Circuit (Vars p.α arity n) := fun s =>
    Circuit.var true (Vars.stateN s n)
  let circs := (List.range n).attach |>.map fun ⟨i, hi⟩ =>
    let si : p.α → Circuit (Vars p.α arity n) := fun s =>
      Circuit.var true (Vars.stateN s i (by simp at hi; omega))
    (mkStateNeqCircuit p si sn)
  Circuit.bigOr circs

/--
make the circuit that witnesses that the states are unique from [0..n]
-/
def mkAllPairsUniqueStatesCircuit {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat) : Circuit (Vars p.α arity n) :=
  let xs := mkLowerTriangularPairs n |>.attach
  Circuit.bigOr <| xs.map fun ⟨(i, j), hij⟩ =>
    let si : p.α → Circuit (Vars p.α arity n) := fun s =>
      Circuit.var true (Vars.stateN s i (by simp at hij; omega))
    let sj : p.α → Circuit (Vars p.α arity n) := fun s =>
      Circuit.var true (Vars.stateN s j (by simp at hij; omega))
    (mkStateNeqCircuit p si sj)



/-- structure for incrementally building the k-induction circuits. -/
structure KInductionCircuits {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity] (fsm : FSM arity) (n : Nat) where
  -- | Circuit that sets states[0][s] = initCarry[s].
  cInitCarryAssignCirc : Circuit (Vars fsm.α arity 0)
  -- | Circuit that set states[i+1]= carry(states[i], inputs[i]) upto 'n'.
  cSuccCarryAssignCirc : Circuit (Vars fsm.α arity (n+2))
  -- | Circuit that sets out[i] = out(states[i], inputs[i]) upto 'n'.
  cOutAssignCirc : Circuit (Vars fsm.α arity (n + 2))
  -- | Circuit that says that states s0..sn are disequal
  cStatesUniqueCirc : Circuit (Vars fsm.α arity (n + 1))

namespace KInductionCircuits

variable {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  {fsm : FSM arity}

/--
Cast a circuit to a larger width, by casting the variables.
-/
def castCircLe {n m : Nat} (c : Circuit (Vars fsm.α arity n)) (hnm : n ≤ m := by omega) :
    Circuit (Vars fsm.α arity m) :=
  c.map (fun v => v.castLe hnm)

/-- Make the carry circuit for the k-induction circuits. -/
def mkZero : KInductionCircuits fsm 0 where
  cInitCarryAssignCirc := mkInitCarryAssignCircuit fsm
  cSuccCarryAssignCirc := mkCarryAssignCircuitLeN fsm 1
  cOutAssignCirc := mkOutputAssignCircuitLeN fsm 1
  cStatesUniqueCirc := mkAllPairsUniqueStatesCircuit fsm 1


-- NOTE [Circuit Equivalence As a quotient]:
-- We ideally should have a notion of `Circuit.equiv`, which says that
-- circuits are equivalent if they denote the same function.
--
-- However, for now, don't bother. We change the direction we compute the `bigOr`
-- of the circuits, so that the latest circuit is the one that is at the outermost
-- layer of the `bigOr`. This way, we can stick a new circuit as
-- `circUptoN+1 = circN+1 || (...circUptoN...)`.

def mkSucc
    (prev : KInductionCircuits fsm n) :
    KInductionCircuits fsm (n + 1) :=
  let cInitCarryAssignCirc := prev.cInitCarryAssignCirc
  { cInitCarryAssignCirc := cInitCarryAssignCirc
  , cSuccCarryAssignCirc :=
      (mkCarryAssignCircuitN fsm (n + 2)) |||
      (castCircLe prev.cSuccCarryAssignCirc)
  , cOutAssignCirc :=
      (mkOutputAssignCircuitN fsm (n + 2)) |||
      (castCircLe prev.cOutAssignCirc)
  , cStatesUniqueCirc :=
      mkStateUniqueCircuitN fsm (n + 2) |||
      (castCircLe prev.cStatesUniqueCirc)
  }

/--
The precondition that assigns all
`s[n+1] = carry(s[n], i[n])` and assigns all `o[n+1] = out(s[n], i[n])`.
-/
def mkSuccCarryAndOutsAssignPrecond (circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  circs.cOutAssignCirc |||
  circs.cSuccCarryAssignCirc


/--
The safety circuit that checks that if `s[0]` is assigned to init carry,
then `o[i] = fals` for all `i ≤ n`.
-/
def mkPostcondSafety (_circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 1)) :=
  mkUnsatImpliesCircuit
    -- | If the initial state is assigned to initCarry,
    (castCircLe <| (mkInitCarryAssignCircuit fsm))
    -- | then the output is fals for all i ≤ n.
    (mkOutEqZeroCircuitLeN fsm n)

/--
The induction hypothesis circuit that checks that if
the output is zero for all `i ≤ n`, then the output is zero at `i=n+1`.
-/
def mkPostcondIndHypNoCycleBreaking {n} (_circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  mkUnsatImpliesCircuit
    -- | If the output is zero for all `i ≤ n`,
    (castCircLe (mkOutEqZeroCircuitLeN fsm <| n))
    -- | Then the output is zero at `i = n+1`
    (mkOutEqZeroCircuitN fsm <| n+1)

/--
If the initial state `s[0] = initCarry`,
and `states[i+1] = carry(states[i], inputs[i])` and `out[i] = out(states[i], inputs[i])`,
then the output is zero for all `i ≤ n`.
-/
def mkSafetyCircuit (circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  mkUnsatImpliesCircuit
    (mkSuccCarryAndOutsAssignPrecond circs)
    (castCircLe <| mkPostcondSafety circs)

/--
If states[i+1] = carry(states[i], inputs[i]) and
out[i] = out(states[i], inputs[i]),
and `out[i] = 0` for all `i ≤ n`,
then the output is zero at `i = n+1`.
-/
def mkIndHypCircuitNoCycleBreaking (circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  mkUnsatImpliesCircuit
    (mkSuccCarryAndOutsAssignPrecond circs)
    -- | Then the output is zero at `i = n+1`
    (mkPostcondIndHypNoCycleBreaking circs)

/--
If states[i+1] = carry(states[i], inputs[i]) and
out[i] = out(states[i], inputs[i]),
and `out[i] = 0` for all `i ≤ n`,
then the output is zero at `i = n+1`.
-/
def mkIndHypCycleBreaking (circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  mkUnsatImpliesCircuit
    (mkSuccCarryAndOutsAssignPrecond circs)
    (mkUnsatImpliesCircuit
      (castCircLe <| circs.cStatesUniqueCirc)
      -- | Then the output is zero at `i = n+1`
      (mkPostcondIndHypNoCycleBreaking circs))


def stats {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    {fsm : FSM arity} (circs : KInductionCircuits fsm n) : CircuitStats where
  iter := n
  size := circs.cSuccCarryAssignCirc.size +
    circs.cOutAssignCirc.size +
    circs.cInitCarryAssignCirc.size

end KInductionCircuits

inductive DecideIfZerosOutput
/-- Safety property fails at this iteration. -/
| safetyFailure (iter : Nat)
/-- Was unable to establish invariant even at these many iterations. -/
| exhaustedIterations (numIters : Nat)
/-- we have proven the safety property for as many steps as the state space size plus one. -/
| provenByExhaustion (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert)
/-- we have proven both the safety and inductive invariant property. -/
| provenByKIndNoCycleBreaking (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert) (indCert : BVDecide.Frontend.LratCert)
/-- we have proven both the safety and inductive invariant property. -/
| provenByKIndCycleBreaking (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert) (indCertCycleBreaking : BVDecide.Frontend.LratCert)

namespace DecideIfZerosOutput
def isSuccess : DecideIfZerosOutput → Bool
  | .safetyFailure _ => false
  | .exhaustedIterations _ => false
  | .provenByExhaustion .. => true
  | .provenByKIndNoCycleBreaking .. => true
  | .provenByKIndCycleBreaking .. => true
end DecideIfZerosOutput

@[nospecialize]
partial def decideIfZerosAuxVerified' {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (iter : Nat) (maxIter : Nat)
    (fsm : FSM arity)
    (circs : KInductionCircuits fsm iter)
    (stats : Array CircuitStats) :
    TermElabM (DecideIfZerosOutput × Array CircuitStats) := do
  withTraceNode `trace.Bits.Fast (fun _ => return s!"K-induction (iter={iter})") do
    if iter ≥ maxIter && maxIter != 0 then
      return (.exhaustedIterations maxIter, stats.push circs.stats)
    let tStart ← IO.monoMsNow
    let cSafety : Circuit (Vars fsm.α arity (iter+2)) := circs.mkSafetyCircuit
    let tEnd ← IO.monoMsNow
    let tElapsedMs := (tEnd - tStart)
    trace[Bits.FastVerif] m!"Built new safety circuit in '{tElapsedMs}ms'"
    -- | don't use these, they rely on exhaustive enumeration which is crazy slow.
    -- let formatα : fsm.α → Format := fun s => "s" ++ formatDecEqFinset s
    -- let formatEmpty : Empty → Format := fun e => e.elim
    -- let formatArity : arity → Format := fun i => "i" ++ formatDecEqFinset i
    -- wtrace[Bits.FastVerif] m!"safety circuit : {formatCircuit (Vars.format formatEmpty formatArity) cSafety}"
    trace[Bits.FastVerif] m!"safety circuit size : {cSafety.size}"
    let tStart ← IO.monoMsNow
    let safetyCert? ← checkCircuitUnsatAux cSafety
    let tEnd ← IO.monoMsNow
    let tElapsedMs := (tEnd - tStart)
    trace[Bits.FastVerif] m!"Established safety property in {tElapsedMs}ms (iter={iter})."
    match safetyCert? with
    | .none =>
      trace[Bits.FastVerif] s!"Safety property failed on initial state."
      return (.safetyFailure iter, stats.push circs.stats)
    | .some safetyCert =>
      if iter ≥ 1 + fsm.stateSpaceSize then
        trace[Bits.FastVerif] s!"Proved safety for the entire state space (state space size: {fsm.stateSpaceSize}). No need to build induction circuit."
        return (.provenByExhaustion iter safetyCert, stats.push circs.stats)

      trace[Bits.FastVerif] s!"Safety property succeeded on initial state. Building induction circuit..."
      let tStart ← IO.monoMsNow
      let cIndHyp := circs.mkIndHypCycleBreaking
      let tEnd ← IO.monoMsNow
      let tElapsedMs := (tEnd - tStart)
      trace[Bits.FastVerif] m!"Built induction circuit in '{tElapsedMs}ms'"

      let tStart ← IO.monoMsNow
      -- trace[Bits.FastVerif] m!"induction circuit: {formatCircuit (Vars.format formatα formatArity) cIndHyp.val}"
      trace[Bits.FastVerif] m!"induction circuit size: {cIndHyp.size}"
      -- let le : Bool := sorry
      let indCert? ← checkCircuitUnsatAux cIndHyp
      let tEnd ← IO.monoMsNow
      let tElapsedMs := (tEnd - tStart)
      trace[Bits.FastVerif] s!"Checked inductive invariant in '{tElapsedMs}ms'."
      match indCert? with
      | .some indCert =>
        trace[Bits.FastVerif] s!"Inductive invariant established (iter={iter})."
        return (.provenByKIndCycleBreaking iter safetyCert indCert, stats.push circs.stats)
      | .none =>
        trace[Bits.FastVerif] s!"Unable to establish inductive invariant. Trying next iteration ({iter+1})..."
    decideIfZerosAuxVerified' (iter + 1) maxIter fsm  circs.mkSucc (stats.push circs.stats)


@[nospecialize]
def _root_.FSM.decideIfZerosVerified {arity : Type _}
    [DecidableEq arity]  [Fintype arity] [Hashable arity]
    (fsm : FSM arity) (maxIter : Nat) :
    TermElabM (DecideIfZerosOutput × Array CircuitStats) :=
  -- decideIfZerosM Circuit.impliesCadical fsm
  withTraceNode `trace.Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    logInfo m!"FSM state space size: {fsm.stateSpaceSize}"
    -- logInfo m!"FSM transition circuit size: {fsm.circuitSize}"
    decideIfZerosAuxVerified' 0 maxIter fsm KInductionCircuits.mkZero #[]


/--
An axiom tracking that the safety has been proven by exhaustion of the state space.
-/
axiom decideIfZerosByExhaustionAx {p : Prop}  : p

/--
An axiom tracking that the safety has been proven by exhaustion of the state space.
-/
axiom decideIfZerosByKInductionNoCycleBreakingAx {p : Prop}  : p


/--
An axiom tracking that the safety has been proven by exhaustion of the state space.
-/
axiom decideIfZerosByKInductionCycleBreakingAx {p : Prop}  : p

end BvDecide

end ReflectVerif
