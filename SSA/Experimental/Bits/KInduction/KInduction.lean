/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `bv_circuit_nnf` to convert the expression into negation normal form.

Authors: Siddharth Bhat

ReflectVerif: https://raw.githubusercontent.com/opencompl/lean-mlir/3e0ff379b5e92427747f8dc84c6f77609bda7e67/SSA/Experimental/Bits/Fast/ReflectVerif.lean
Tactic: https://raw.githubusercontent.com/opencompl/lean-mlir/3e0ff379b5e92427747f8dc84c6f77609bda7e67/SSA/Experimental/Bits/Frontend/Tactic.lean

-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Defs
import Mathlib.Data.Multiset.FinsetOps
import SSA.Experimental.Bits.SingleWidth.Defs
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Decide
import SSA.Experimental.Bits.SingleWidth.Syntax
import SSA.Experimental.Bits.SingleWidth.Preprocessing
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec
import SSA.Experimental.Bits.Fast.ForLean
import SSA.Experimental.Bits.Vars
import SSA.Experimental.Bits.EnvBitstream

import Lean

open Fin.NatCast

set_option linter.unusedSectionVars false

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
    (p.nextStateCirc s).map fun v =>
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
    ((mkCarryAssignCircuitNAux p s n).eval env) = ((p.nextStateCirc s).eval env') := by
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
    ((mkCarryAssignCircuitNAux p s n).eval env) = ((p.nextStateCirc s).eval
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

theorem eval_mkInitCarryAssignCircuit_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity)
  {env : Vars p.α arity 0 → Bool} :
  (mkInitCarryAssignCircuit p).eval env = false ↔
  (∀ (s : p.α), p.initCarry s = env (Vars.state0 s)) := by
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
    (p.outputCirc).map fun v =>
      match v with
        | .inl s' => Vars.stateN s' n
        | .inr i => Vars.inputN i n

@[simp]
theorem eval_mkOutputAssignCircuitNAux_eq {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat) (env : Vars p.α arity (n + 1) → Bool) :
  (mkOutputAssignCircuitNAux p n).eval env =
    (p.outputCirc).eval
      (fun x => match x with
        | .inl s => env (Vars.stateN s n)
        | .inr i => env (Vars.inputN i n)) := by
  rw [mkOutputAssignCircuitNAux]
  simp [Circuit.eval_map]
  congr
  ext x
  rcases x with x | x <;> simp

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

@[simp]
theorem eval_mkOutputAssignCircuitN_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat)
  {env : Vars p.α arity (n + 1) → Bool}
  :
  ((mkOutputAssignCircuitN p n).eval env = false) ↔
    (p.outputCirc).eval
      (fun x => match x with
        | .inl s => env (Vars.stateN s n)
        | .inr i => env (Vars.inputN i n)) =
    env (Vars.outputs ⟨n, by omega⟩) := by
  rw [mkOutputAssignCircuitN]
  simp [eval_mkOutputAssignCircuitNAux_eq]


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


theorem mkOutputAssignCircuitLeN_eq_false_iff {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity] (p : FSM arity) (n : Nat)
  (env : Vars p.α arity (n + 1) → Bool) :
  ((mkOutputAssignCircuitLeN p n).eval env = false) ↔
  (∀ (i : Nat) (hi : i < n + 1),
    (p.outputCirc).eval
      (fun x => match x with
        | .inl s => env (Vars.stateN s i)
        | .inr j => env (Vars.inputN j i)) =
    env (Vars.outputs ⟨i, by omega⟩)) := by
  rw [mkOutputAssignCircuitLeN]
  simp only [Circuit.eval_bigOr_eq_false_iff, List.mem_map, List.mem_attach, true_and,
    Subtype.exists, List.mem_range, forall_exists_index]
  constructor
  · intros h i hi
    specialize h ?c i (by omega) rfl
    simp only [Circuit.eval_map, eval_mkOutputAssignCircuitN_eq_false_iff] at h
    apply h
  · intros h c i hi hc
    subst hc
    simp only [Circuit.eval_map, eval_mkOutputAssignCircuitN_eq_false_iff]
    simp only at h
    specialize h i hi
    simp only [Vars.castLe_outputs_mk_eq_outputs]
    rw [← h]
    congr
/--
Make a circuit that checks `out[n] = fals`.
-/
@[simp]
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

@[simp]
theorem mkOutEqZeroCircuitN_eval_eq_false_iff {arity : Type _}
  [DecidableEq arity]
  [Fintype arity]
  [Hashable arity]
  (p : FSM arity) (n : Nat)
  {env : Vars p.α arity (n + 1) → Bool} :
  ((mkOutEqZeroCircuitN p n).eval env = false) ↔
    env (Vars.outputs ⟨n, by omega⟩) = false := by
  rw [mkOutEqZeroCircuitN]
  simp

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

theorem mkOutEqZeroCircuitLeN_eval_eq_false_iff {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity] (p : FSM arity) (n : Nat)
  (env : Vars p.α arity (n + 1) → Bool) :
  ((mkOutEqZeroCircuitLeN p n).eval env = false) ↔
  (∀ (i : Nat) (hi : i < n + 1),
    env (Vars.outputs ⟨i, by omega⟩) = false) := by
  rw [mkOutEqZeroCircuitLeN]
  simp only [Circuit.eval_bigOr_eq_false_iff, List.mem_map, List.mem_attach, true_and,
    Subtype.exists, List.mem_range, forall_exists_index]
  constructor
  · intros h i hi
    specialize h ?c i (by omega) rfl
    simp only [Circuit.eval_map, mkOutEqZeroCircuitN_eval_eq_false_iff] at h
    apply h
  · intros h c i hi hc
    subst hc
    simp only [Circuit.eval_map, mkOutEqZeroCircuitN_eval_eq_false_iff]
    apply h i hi

theorem mkOutEqZeroCircuitLeN_eval_eq_false_iff₂ {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity] (p : FSM arity) (n : Nat) :
  (∀ (env : Vars p.α arity (n + 1) → Bool), (mkOutEqZeroCircuitLeN p n).eval env = false) ↔
  (∀ (env : Vars p.α arity (n + 1) → Bool) (i : Nat), (hi : i < n + 1) → env (Vars.outputs ⟨i, by omega⟩) = false) := by
  simp [mkOutEqZeroCircuitLeN_eval_eq_false_iff]


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
theorem mem_mkLowerTriangularPairs {n : Nat} {i j : Nat} :
  ((i, j) ∈ mkLowerTriangularPairs n) ↔
  (i < j ∧ j ≤ n) := by
  simp [mkLowerTriangularPairs]
  omega

@[simp]
theorem mem_mkLowerTriangularPairs₂  {n : Nat} {ij :  Nat × Nat} :
  (ij ∈ mkLowerTriangularPairs n) ↔
  (ij.1 < ij.2 ∧ ij.2 ≤ n) := by
  obtain ⟨i, j⟩ := ij
  simp

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

theorem mkStateUniqueCircuitN_eq_false_iff {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat)
  {env : Vars p.α arity n → Bool} :
  ((mkStateUniqueCircuitN p n).eval env = false) ↔
  (∀ (i : Nat) (hi : i < n), ∃ (s : p.α), env (Vars.stateN s i) ≠ env (Vars.stateN s n)) := by
  rw [mkStateUniqueCircuitN]
  simp only [Circuit.eval_bigOr_eq_false_iff, List.mem_map, List.mem_attach, true_and,
    Subtype.exists, List.mem_range, forall_exists_index]
  constructor
  · intros h i hi
    specialize h ?c i hi rfl
    simpa using h
  · intros h c i hi hc
    subst hc
    specialize h i hi
    simpa using h
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

theorem mkAllPairsUniqueStatesCircuit_eq_false_iff {arity : Type _}
  [DecidableEq arity] [Fintype arity] [Hashable arity]
  (p : FSM arity) (n : Nat)
  {env : Vars p.α arity n → Bool} :
  ((mkAllPairsUniqueStatesCircuit p n).eval env = false) ↔
  (∀ (i j : Nat) (hij : i < j ∧ j ≤ n), ∃ (s : p.α), env (Vars.stateN s i) ≠ env (Vars.stateN s j)) := by
  rw [mkAllPairsUniqueStatesCircuit]
  simp only [Circuit.eval_bigOr_eq_false_iff, List.mem_map, List.mem_attach, true_and,
    Subtype.exists, forall_exists_index]
  constructor
  · intros h i j hij
    simp only [Prod.forall, mem_mkLowerTriangularPairs] at h
    specialize h ?c i j hij rfl
    simpa using h
  · intros h c ij hij hc
    subst hc
    simp only [mkStateNeqCircuit_eq_false_iff₂, Circuit.eval, ↓reduceIte, ne_eq]
    obtain ⟨i, j⟩ := ij
    simp only [mem_mkLowerTriangularPairs₂] at hij
    simp only [ne_eq] at ⊢ h
    apply h i j hij

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
  cStatesUniqueCirc : Circuit (Vars fsm.α arity n)

structure KInductionCircuits.IsLawful {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity] {fsm : FSM arity} {n : Nat}
  (circs : KInductionCircuits fsm n) where
  hCInitCarryAssignCirc :
    ∀ {env : Vars fsm.α arity 0 → Bool},
      (circs.cInitCarryAssignCirc.eval env = false)
      ↔ (∀ (s : fsm.α), fsm.initCarry s = env (Vars.state0 s))

  hCSuccCarryAssignCirc :
    ∀ {env : Vars fsm.α arity (n + 2) → Bool},
      (circs.cSuccCarryAssignCirc.eval env = false)
      ↔ (∀ (s : fsm.α) (i : Nat) (hi : i < n + 2),
        env (Vars.stateN s (i + 1)) =
          ((mkCarryAssignCircuitNAux fsm s i).map
            (fun v => v.castLe (by omega))).eval env)
  hCOutAssignCirc :
    ∀ {env : Vars fsm.α arity (n + 2) → Bool},
      (circs.cOutAssignCirc.eval env = false)
      ↔ (∀ (i : Nat) (hi : i < n + 2),
        (fsm.outputCirc).eval
          (fun x => match x with
            | .inl s => env (Vars.stateN s i)
            | .inr j => env (Vars.inputN j i)) =
        env (Vars.outputs ⟨i, by omega⟩))
  hCStatesUniqueCirc :
    ∀ {env : Vars fsm.α arity (n) → Bool},
      (circs.cStatesUniqueCirc.eval env = false)
      ↔ (∀ (i j : Nat) (hij : i < j ∧ j ≤ n),
        ∃ (s : fsm.α), env (Vars.stateN s i) ≠ env (Vars.stateN s j))

attribute [simp] KInductionCircuits.IsLawful.hCInitCarryAssignCirc
attribute [simp] KInductionCircuits.IsLawful.hCSuccCarryAssignCirc
attribute [simp] KInductionCircuits.IsLawful.hCOutAssignCirc
attribute [simp] KInductionCircuits.IsLawful.hCStatesUniqueCirc

namespace KInductionCircuits

variable {arity : Type _}
  {fsm : FSM arity}

/--
Cast a circuit to a larger width, by casting the variables.
-/
def castCircLe {n m : Nat} (c : Circuit (Vars fsm.α arity n)) (hnm : n ≤ m := by omega) :
    Circuit (Vars fsm.α arity m) :=
  c.map (fun v => v.castLe hnm)

@[simp]
theorem eval_castCircLe_eq {n m : Nat} (c : Circuit (Vars fsm.α arity n))
    (hnm : n ≤ m)
    {env : Vars fsm.α arity m → Bool} :
    (castCircLe c hnm).eval env = c.eval
      (fun x => env (x.castLe hnm)) := by
  simp [castCircLe, Circuit.eval_map]


variable [DecidableEq arity] [Fintype arity] [Hashable arity]

/-- Make the carry circuit for the k-induction circuits. -/
def mkZero : KInductionCircuits fsm 0 where
  cInitCarryAssignCirc := mkInitCarryAssignCircuit fsm
  cSuccCarryAssignCirc := mkCarryAssignCircuitLeN fsm 1
  cOutAssignCirc := mkOutputAssignCircuitLeN fsm 1
  cStatesUniqueCirc := mkAllPairsUniqueStatesCircuit fsm 0

theorem IsLawful_mkZero {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (fsm : FSM arity) :
    (mkZero (fsm := fsm)).IsLawful where
  hCInitCarryAssignCirc := by
    intro s
    simp only [mkZero]
    simp only [eval_mkInitCarryAssignCircuit_eq_false_iff]
  hCSuccCarryAssignCirc := by
    intro env
    simp only [mkZero]
    simp only [mkCarryAssignCircuitLeN_eq_false_iff]
  hCOutAssignCirc := by
    intro env
    simp only [mkZero]
    simp only [mkOutputAssignCircuitLeN_eq_false_iff]
  hCStatesUniqueCirc := by
    intro env
    simp [mkZero, mkAllPairsUniqueStatesCircuit_eq_false_iff]

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
      mkStateUniqueCircuitN fsm (n + 1) |||
      (castCircLe prev.cStatesUniqueCirc)
  }

theorem IsLawful_mkSucc_of_IsLawful {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    {fsm : FSM arity} {n : Nat}
    (prev : KInductionCircuits fsm n)
    (hPrev : prev.IsLawful) :
    (mkSucc prev).IsLawful where
  hCInitCarryAssignCirc := by
    simp only [mkSucc, castCircLe]
    exact hPrev.hCInitCarryAssignCirc
  hCSuccCarryAssignCirc := by
    simp only [mkSucc, castCircLe, Circuit.eval_map]
    simp [Circuit.eval_map]
    intros env
    constructor
    · intros h s i hi
      obtain ⟨h₁, h₂⟩ := h
      rw [hPrev.hCSuccCarryAssignCirc] at h₂
      by_cases hi : i < n + 2
      · simp only [Vars.castLe_stateN_eq_stateN, Circuit.eval_map,
        Vars.castLe_castLe_eq_castLe_self, mkCarryAssignCircuitNAux_eval_eq,
        Vars.castLe_inputs_eq_inputs] at h₂
        rw [h₂ s i hi]
      · have hi : i = n + 2 := by omega
        subst hi
        apply h₁
    · intros h
      constructor
      · intros s
        simp only at h ⊢
        rw [h s _ (by omega)]
      · rw [hPrev.hCSuccCarryAssignCirc]
        intros s i hi
        simp only at h
        simp only [Vars.castLe_stateN_eq_stateN, Circuit.eval_map,
          Vars.castLe_castLe_eq_castLe_self, mkCarryAssignCircuitNAux_eval_eq,
          Vars.castLe_inputs_eq_inputs]
        rw [h s i (by omega)]

  hCOutAssignCirc := by
    simp only [mkSucc, castCircLe]
    simp [Circuit.eval_map]
    intros env
    constructor
    · intros h i hi
      obtain ⟨h₁, h₂⟩ := h
      rw [hPrev.hCOutAssignCirc] at h₂
      by_cases hi : i < n + 2
      · simp at h₁ h₂ ⊢
        rw [h₂ i hi]
      · have : i = n + 2 := by omega
        subst this
        apply h₁
    · intros h
      constructor
      · simp only at h ⊢
        rw [h]
      · rw [hPrev.hCOutAssignCirc]
        intros i hi
        simp
        apply h
  hCStatesUniqueCirc := by
    simp only [mkSucc, castCircLe]
    simp [Circuit.eval_map]
    intros env
    constructor
    · intros h i j hij
      simp [mkStateUniqueCircuitN_eq_false_iff] at h
      simp [hPrev.hCStatesUniqueCirc] at h
      obtain ⟨h₁, h₂⟩ := h
      by_cases hj : j ≤ n
      · grind
      · intros
        have : j = n + 1 := by omega
        subst this
        apply h₁ i (by omega)
    · intros h
      constructor
      · rw [mkStateUniqueCircuitN_eq_false_iff]
        intros i hi
        apply h _ (j := n + 1) (by omega) (by omega)
      · simp [hPrev.hCStatesUniqueCirc]
        grind

/--
Construct the induction circuits for a given FSM and depth.
-/
def mkN (fsm : FSM arity) (n : Nat) : KInductionCircuits fsm n :=
  match n with
  | 0 => mkZero
  | n + 1 => mkSucc (mkN fsm n)


/-- The circuits constructed by `mkN` are lawful. -/
def IsLawful_mkN {arity : Type _}
    [DecidableEq arity] [Fintype arity] [Hashable arity]
    (fsm : FSM arity) (n : Nat) :
    (mkN fsm n).IsLawful := by
  induction n with
  | zero => exact IsLawful_mkZero fsm
  | succ n ih =>
    apply IsLawful_mkSucc_of_IsLawful
    exact ih

/--
The precondition that assigns all
`s[n+1] = carry(s[n], i[n])` and assigns all `o[n+1] = out(s[n], i[n])`.
-/
def mkSuccCarryAndOutsAssignPrecond (circs : KInductionCircuits fsm n) :
    Circuit (Vars fsm.α arity (n + 2)) :=
  circs.cOutAssignCirc |||
  circs.cSuccCarryAssignCirc

/--
Since the `mkSuccCarryAndOutsAssignPrecond` produces a large
condition, we keep it as-is, and use it evaluating to false
as a precondition.
-/
theorem eval_mkSuccCarryAndOutAssignPrecond_eq_false_iff₁
  {circs : KInductionCircuits fsm n}
  (hCircs : circs.IsLawful) :
  ∀ (env : Vars fsm.α arity (n + 2) → Bool),
  (mkSuccCarryAndOutsAssignPrecond circs).eval env = false ↔
  (∀ (s : fsm.α) (i : Nat) (hi : i < n + 2),
    env (Vars.stateN s (i + 1)) =
      ((mkCarryAssignCircuitNAux fsm s i).map
        (fun v => v.castLe (by omega))).eval env) ∧
  (∀ (i : Nat) (hi : i < n + 2),
    (fsm.outputCirc).eval
      (fun x => match x with
        | .inl s => env (Vars.stateN s i)
        | .inr j => env (Vars.inputN j i)) =
    env (Vars.outputs ⟨i, by omega⟩)) := by
  intro env
  rw [mkSuccCarryAndOutsAssignPrecond]
  simp only [Circuit.eval_or, Bool.or_eq_false_iff, hCircs, IsLawful.hCOutAssignCirc,
    IsLawful.hCSuccCarryAssignCirc]
  simp [Circuit.eval_map]
  constructor
  · intros h
    obtain ⟨h₁, h₂⟩ := h
    constructor
    · intros s k hk
      apply h₂ s k (by omega)
    · intros k hk
      apply h₁ k (by omega)
  · intros h
    obtain ⟨h₁, h₂⟩ := h
    constructor
    · intros k hk
      apply h₂ k (by omega)
    · intros s k hk
      apply h₁ s k (by omega)


@[simp]
theorem mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBool_of_envBitstream_of_state
  {circs : KInductionCircuits fsm n}
  (hCircs : circs.IsLawful)
  (env : Vars fsm.α arity (n + 2) → Bool)
  (s0 : fsm.α → Bool)
  (hEnv : env = envBool_of_envBitstream_of_state fsm envBitstream s0 (n + 1)) :
  (mkSuccCarryAndOutsAssignPrecond circs).eval env = false := by
  rw [eval_mkSuccCarryAndOutAssignPrecond_eq_false_iff₁ hCircs env]
  subst hEnv
  simp [envBool_of_envBitstream_of_state]
  constructor
  · intros s i hi
    simp [Vars.stateN]
    simp [Circuit.eval_map]
    simp [envBool_of_envBitstream_of_state, Vars.stateN, Vars.inputN]
    rw [FSM.carryWith, FSM.carry, FSM.nextBit]
    simp
    congr
    ext x
    rcases x with x | x
    · rfl
    · simp
  · intros i hi
    congr
    ext x
    rcases x with x | x
    · simp [Vars.stateN]
      rfl
    · simp [Vars.inputN]

-- | TODO: remove duplication, reuse
-- `mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBool_of_envBitstream_of_state`
-- to work.
@[simp]
theorem mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBoolStart_of_envBitstream
  {circs : KInductionCircuits fsm n}
  (hCircs : circs.IsLawful)
  (env : Vars fsm.α arity (n + 2) → Bool)
  (hEnv : env = envBoolStart_of_envBitstream fsm envBitstream (n + 1)) :
  (mkSuccCarryAndOutsAssignPrecond circs).eval env = false := by
  rw [eval_mkSuccCarryAndOutAssignPrecond_eq_false_iff₁ hCircs env]
  subst hEnv
  simp [envBoolStart_of_envBitstream, envBool_of_envBitstream_of_state]
  constructor
  · intros s i hi
    simp [Vars.stateN]
    simp [Circuit.eval_map]
    simp [envBool_of_envBitstream_of_state, Vars.stateN, Vars.inputN]
    simp [FSM.carry, FSM.nextBit]
    congr
    ext x
    rcases x with x | x
    · simp
    · simp
  · intros i hi
    simp [FSM.eval, FSM.nextBit]
    congr
    ext x
    rcases x with x | x
    · simp [Vars.stateN]
    · simp [Vars.inputN]

@[simp]
theorem mkSuccCarryAndOutsAssignPrecond_eval_envBoolStart_of_envBitstream_eq_false
  {circs : KInductionCircuits fsm n}
  (hCircs : circs.IsLawful)
  (envBitstream : _ ) :
  (mkSuccCarryAndOutsAssignPrecond circs).eval
    (envBoolStart_of_envBitstream fsm envBitstream (n + 1)) = false := by
  apply mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBoolStart_of_envBitstream <;>
    solve
    | assumption
    | rfl

@[simp]
theorem mkSuccCarryAndOutsAssignPrecond_eval_envBool_of_envBitstream_of_state_eq_false
  {circs : KInductionCircuits fsm n}
  (hCircs : circs.IsLawful)
  (envBitstream : _ ) :
  (mkSuccCarryAndOutsAssignPrecond circs).eval
    (envBool_of_envBitstream_of_state fsm envBitstream s0 (n + 1)) = false := by
  apply mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBool_of_envBitstream_of_state <;>
    solve
    | assumption
    | rfl


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

set_option linter.unusedVariables false in
theorem eval_mkPostcondSafety_eq_false_iff
    {circs : KInductionCircuits fsm n}
    (hCircs : circs.IsLawful)
    (env : Vars fsm.α arity (n + 1) → Bool) :
    ((mkPostcondSafety circs).eval env = false) ↔
    ((∀ (s : fsm.α), fsm.initCarry s = env ((Vars.state0 s))) →
    (∀ (i : Nat) (hi : i < n + 1), env (Vars.outputs ⟨i, by omega⟩) = false)) := by
  rw [mkPostcondSafety]
  simp only [mkUnsatImpliesCircuit_eq_false_iff]
  simp
  constructor
  · intros h hinit i hi
    simp only at h
    rw [eval_mkInitCarryAssignCircuit_eq_false_iff] at h
    rw [mkOutEqZeroCircuitLeN_eval_eq_false_iff] at h
    apply h
    apply hinit
  · intros h
    rw [mkOutEqZeroCircuitLeN_eval_eq_false_iff]
    rw [eval_mkInitCarryAssignCircuit_eq_false_iff]
    intros hpre
    apply h
    apply hpre
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

set_option linter.unusedVariables false in
theorem mkPostcondIndHypNoCycleBreaking_eq_false_iff
    {circs : KInductionCircuits fsm n}
    (hCircs : circs.IsLawful)
    (env : Vars fsm.α arity (n + 2) → Bool) :
    ((mkPostcondIndHypNoCycleBreaking circs).eval env = false) ↔
    ((∀ (i : Nat) (hi : i < n + 1), env (Vars.outputs ⟨i, by omega⟩) = false) →
    env (Vars.outputs ⟨n + 1, by omega⟩) = false) := by
  rw [mkPostcondIndHypNoCycleBreaking]
  simp only [mkUnsatImpliesCircuit_eq_false_iff]
  simp
  constructor
  · simp [mkOutEqZeroCircuitLeN_eval_eq_false_iff]
  · simp [mkOutEqZeroCircuitLeN_eval_eq_false_iff]

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


theorem mkSafetyCircuit_eval_eq_false_iff₁
    {circs : KInductionCircuits fsm n}
    (hCircs : circs.IsLawful)
    (env : Vars fsm.α arity (n + 2) → Bool) :
    ((mkSafetyCircuit circs).eval env = false) ↔
    ((mkSuccCarryAndOutsAssignPrecond circs).eval env = false →
      (∀ (s : fsm.α), fsm.initCarry s = env (Vars.state0 s)) →
      (∀ (i : Nat) (hi : i < n + 1), env (Vars.outputs ⟨i, by omega⟩) = false)) := by
  rw [mkSafetyCircuit]
  simp only [mkUnsatImpliesCircuit_eq_false_iff]
  simp
  constructor
  · intros h hinit hsafe i hi
    rw [eval_mkPostcondSafety_eq_false_iff] at h
    · simp at h
      apply h
      · apply hinit
      · apply hsafe
      · omega
    · apply hCircs
  · intros h
    intros hPrecond
    rw [eval_mkPostcondSafety_eq_false_iff]
    simp
    apply h
    · apply hPrecond
    · apply hCircs


/--
Safe upto n steps, given that `mkSafetyCircuit.eval env = false` for all `env`.
-/
theorem mkSafetyCircuit_eval_eq_false_thm
    {circs : KInductionCircuits fsm n}
    (hCircs : circs.IsLawful)
    (h : ∀ (env : _), (mkSafetyCircuit circs).eval env = false) :
    (∀ (envBitstream : _) (i : Nat), i < n + 1 → fsm.eval envBitstream i = false) := by
  intros envBitstream i hi
  let env := envBoolStart_of_envBitstream fsm envBitstream (n + 1)
  specialize h env
  rw [mkSafetyCircuit_eval_eq_false_iff₁ hCircs env] at h
  subst env
  have := mkSuccCarryAndOutsAssignPrecond_eval_envBoolStart_of_envBitstream_eq_false
    hCircs envBitstream
  specialize h this
  clear this
  simp at h
  specialize h ?precond
  · intros s
    simp [envBoolStart_of_envBitstream, envBool_of_envBitstream_of_state, Vars.stateN]
  · simp [envBoolStart_of_envBitstream, envBool_of_envBitstream_of_state] at h
    apply h
    · omega

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

@[simp]
theorem mkIndHypCircuitNoCycleBreaking_eval_eq_false_iff
    {circs : KInductionCircuits fsm n}
    (env : Vars fsm.α arity (n + 2) → Bool) :
    ((mkIndHypCircuitNoCycleBreaking circs).eval env = false) ↔
    ((mkSuccCarryAndOutsAssignPrecond circs).eval env = false → (mkPostcondIndHypNoCycleBreaking circs).eval env = false) := by
  simp [mkIndHypCircuitNoCycleBreaking]

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

theorem mkIndHypCycleBreaking_eval_eq_false_iff₁
    {circs : KInductionCircuits fsm n}
    (env : Vars fsm.α arity (n + 2) → Bool) :
    ((mkIndHypCycleBreaking circs).eval env = false) ↔
    ((mkSuccCarryAndOutsAssignPrecond circs).eval env = false →
      (circs.cStatesUniqueCirc.eval (fun x => env (x.castLe (by omega))) = false) →
      (mkPostcondIndHypNoCycleBreaking circs).eval env = false) := by
  simp [mkIndHypCycleBreaking, mkUnsatImpliesCircuit_eq_false_iff]


/--
the states in `fsm` starting from state `s0`, with inputs `inputs` is all unique.
-/
def StatesUniqueLe (fsm : FSM arity) (s0 : fsm.α → Bool) (inputs : arity → BitStream) (n : Nat) : Prop :=
    ∀ (i j : Nat), i < j ∧ j ≤ n →
    (fsm.carryWith s0 inputs i) ≠ (fsm.carryWith s0 inputs j)

@[simp] theorem StatesUniqueLe_zero {fsm : FSM arity} {s0 : fsm.α → Bool} {inputs : arity → BitStream} :
  StatesUniqueLe fsm s0 inputs 0 := by
  intros i j hij
  simp at hij
  omega

/--
Show what the induction hypothesis with cycle breaking circuit implies.
-/
theorem  mkIndHypCycleBreaking_eval_eq_false_thm_aux
  {circs : KInductionCircuits fsm n}
  (hcircs : circs.IsLawful)
  (h : ∀ (env : _), (mkIndHypCycleBreaking circs).eval env = false) :
  (∀ (envBitstream : _) (s0 : _), (∀ (i : Nat) (j : Nat), i < j ∧ j ≤ n →
      (fsm.carryWith s0 envBitstream i) ≠ (fsm.carryWith s0 envBitstream j)) →
      (∀ (k : Nat), k < n + 1 → fsm.evalWith s0 envBitstream k = false) →
      (fsm.evalWith s0 envBitstream (n + 1) = false)) := by
  simp [mkIndHypCycleBreaking_eval_eq_false_iff₁] at h
  intros envBitstream s0 huniq hind
  let env := envBool_of_envBitstream_of_state fsm envBitstream s0 (n + 1)
  specialize h env
  specialize h ?precond ?huniq
  · apply mkSuccCarryAndOutsAssignPrecond_eval_eq_false_of_eq_envBool_of_envBitstream_of_state
      (envBitstream := envBitstream) (s0 := s0)
    · exact hcircs
    · simp [env]
  · rw [hcircs.hCStatesUniqueCirc]
    intros i j hij
    specialize huniq i j hij
    -- show that `(Vars.stateN s i)` equals `fsm.eval ...`
    -- | TODO: cleanup this, with
    -- envBoolStart_of_envBitstream,
    -- envBool_of_envBitstream_of_state, Vars.stateN
    -- as a single lemma.
    simp [env, envBool_of_envBitstream_of_state, Vars.stateN]
    rw [← Function.ne_iff]
    exact huniq
    -- specialize huniq i j hij
  · rw [mkPostcondIndHypNoCycleBreaking_eq_false_iff] at h
    simp [env, envBool_of_envBitstream_of_state] at h
    apply h
    apply hind
    exact hcircs


/-- Show that the 'mkIndHypCycleBreaking' theorem establishes safety for all unique paths. -/
theorem  mkIndHypCycleBreaking_eval_eq_false_thm
  {circs : KInductionCircuits fsm n}
  (hcircs : circs.IsLawful)
  (h : ∀ (env : _), (mkIndHypCycleBreaking circs).eval env = false) :
  (∀ (envBitstream : _) (s0 : _), StatesUniqueLe fsm s0 envBitstream n →
      (∀ (k : Nat), k < n + 1 → fsm.evalWith s0 envBitstream k = false) →
      (fsm.evalWith s0 envBitstream (n + 1) = false)) := by
  simp [StatesUniqueLe]
  intros envBitstream s0 hind
  apply mkIndHypCycleBreaking_eval_eq_false_thm_aux (circs := circs) (hcircs := hcircs)
  · apply h
  · intros i j hij
    apply hind
    · omega
    · omega


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


/--
`eval` is false iff we establish the safety and induction hypothesis.
-/
theorem eval_eq_false_of_eval_eq_false_le_n_of_eval_eq_false_le_n_of_eval_eq_false_le_n {n : Nat}
    {arity : Type _} [DecidableEq arity] [Fintype arity] [Hashable arity]
    (p : FSM arity)
    (hs : ∀ (envBitstream : arity → BitStream), ∀ i ≤ n, p.eval envBitstream i = false)
    (hind : ∀ (state : p.α → Bool) (envBitstream : arity → BitStream),
    (∀ i ≤ n, p.evalWith state envBitstream i = false) →
      p.evalWith state envBitstream (n + 1) = false)
    :
    ∀ (envBitstream : arity → BitStream) (i : Nat), p.eval envBitstream i = false := by
  intros envBitstream i
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

/--
Make a simple path corresponding to inputs[:n],
such that carryWith fsm s0 inputs n = carryWith fsm s0 out.inputs out.k,
where `k ≤ n`, and moreover, `out.inputs` is a simple path.
-/
structure SimplePathOfPath (fsm : FSM arity) (s0 : fsm.α → Bool) (n : Nat) (inputs : arity → BitStream) where
  simplePath : arity → BitStream
  k : Nat
  hkLt : k ≤ n
  hCarryWith :  fsm.carryWith s0 inputs n = fsm.carryWith s0 simplePath k
  -- /-- We pick a subsequence of paths. -/
  -- hCarryWith_of_le : ∀ (i : Nat), i ≤ k →
  --   ∃ j : Nat, j ≤ n ∧ fsm.carryWith s0 simplePath i = fsm.carryWith s0 inputs j
  hStatesUniqueLe : StatesUniqueLe fsm s0 simplePath k


/--
This shows that `fsm.carry` at the end is unchanged.
-/
def SimplePathOfPath.hCarry (this : SimplePathOfPath fsm s0 n inputs)
  (hs0 : s0 = fsm.initCarry := by rfl) :
    fsm.carry inputs n = fsm.carry this.simplePath this.k := by
  rw [FSM.carry_eq_carryWith_initCarry]
  subst hs0
  apply this.hCarryWith

/--
Find the occurrence of a state 's' in the simple path.
-/
noncomputable def SimplePathOfPath.findStateOnSimplePath?
  (this : SimplePathOfPath fsm s0 n inputs)
  (s : fsm.α → Bool) :
    { k? : Option Nat //
      ∀ (k : Nat),
      (k? = some k ↔ k ≤ this.k ∧ fsm.carryWith s0 this.simplePath k = s ∧ ∀ l < k, fsm.carryWith s0 this.simplePath l ≠ s) } :=
  let states :=
    (List.range (this.k + 1)).map fun i =>
      fsm.carryWith s0 this.simplePath i
  let out := states.findIdx? (fun t => t = s)
  match hout : out with
  | none =>
    ⟨none, by
      simp only [reduceCtorEq, ne_eq, false_iff, not_and, not_forall, Decidable.not_not]
      subst out
      have := List.findIdx?_eq_none_iff |>.mp hout
      subst states
      simp only [List.mem_map, List.mem_range, decide_eq_false_iff_not, forall_exists_index,
        and_imp, forall_apply_eq_imp_iff₂] at this
      intros k hk
      intros hcontra
      specialize this k (by omega)
      contradiction
    ⟩
  | some idx =>
    ⟨some idx, by
      have := List.findIdx?_eq_some_iff_findIdx_eq .. |>.mp hout
      obtain ⟨h₁, h₂⟩ := this
      intros k
      simp only [Option.some.injEq, ne_eq]
      constructor
      · intros hk
        subst hk
        constructor
        · simp only [List.findIdx?_map, List.length_map, List.length_range, out, states] at *
          omega
        · have := List.findIdx_eq h₁ |>.mp h₂
          simp at this
          obtain ⟨hidx, hfirst⟩ := this
          simp only [List.getElem_map, List.getElem_range, states] at hidx
          constructor
          · simp only [hidx]
          · intros l hl
            simp only [List.getElem_map, List.getElem_range, states] at hfirst
            apply hfirst
            omega
      . intros hk
        obtain ⟨hkLt, hk, hneq⟩ := hk
        rw [← h₂]
        have hkLt₂ : k < states.length := by
          simp only [List.length_map, List.length_range, states]
          omega
        apply (List.findIdx_eq hkLt₂ |>.mpr)
        simp only [List.getElem_map, List.getElem_range, hk, decide_true, decide_eq_false_iff_not,
          true_and, states]
        apply hneq
    ⟩

theorem SimplePathOfPath.findState?_eq_none_iff (this : SimplePathOfPath fsm s0 n inputs)
    (s : fsm.α → Bool) :
  (this.findStateOnSimplePath? s).val = none ↔
  ∀ (k : Nat), k ≤ this.k → fsm.carryWith s0 this.simplePath k ≠ s := by
  simp only [ne_eq, findStateOnSimplePath?]
  split
  case h_1 hfind =>
    simp only [List.findIdx?_map, List.findIdx?_eq_none_iff, List.mem_range, Function.comp_apply,
      decide_eq_false_iff_not] at hfind
    simp only [true_iff]
    intros k hk
    apply hfind
    omega
  case h_2 hfind idx hidx =>
    simp only [reduceCtorEq, false_iff, not_forall, Decidable.not_not]
    simp only [List.findIdx?_map] at hidx
    obtain ⟨hidxLt, hidxVal⟩ := List.findIdx?_eq_some_iff_findIdx_eq .. |>.mp hidx
    simp only [List.length_range] at hidxLt
    have hkLt₂ : idx < (List.range (this.k + 1)).length := by
      simp only [List.length_range]
      omega
    have := List.findIdx_eq hkLt₂ |>.mp hidxVal
    simp only [List.getElem_range, Function.comp_apply, decide_eq_true_eq,
      decide_eq_false_iff_not] at this
    exists idx
    constructor
    · simp [this]
    · omega

/--
set values for index `i` in the environment `x`,
where `v` is the value to set.
-/
def envBitstream_set (x : arity → BitStream) (n : Nat) (v : arity → Bool) :
    arity → BitStream :=
  fun a j => if j = n then v a else x a j

@[simp]
def envBitstream_set_self_eq_self (x : arity → BitStream) (n : Nat) :
    (envBitstream_set x n (fun a => x a n)) = x := by
  ext a i
  simp [envBitstream_set]
  intros hi
  subst hi
  rfl

@[simp]
theorem envBitstream_set_eq_self_of_ne {x : arity → BitStream}
    {n k : Nat} {v : arity → Bool} {a : arity} (hneq : k ≠ n) :
  (envBitstream_set x n v) a k = x a k := by
  simp [envBitstream_set, hneq]

@[simp]
theorem envBitstream_set_eq_of_eq {x : arity → BitStream} {n k : Nat} {v : arity → Bool}
    {a : arity} (hneq : k = n) :
    (envBitstream_set x n v) a k = v a := by
  simp [envBitstream_set, hneq]

@[simp]
theorem envBitstream_set_eq_of_eq₂   {x : arity → BitStream}
    {n : Nat} {v : arity → Bool} {a : arity} :
  (envBitstream_set x n v) a n = v a := by
  simp [envBitstream_set]

/-- if env = env' upto n < k, then we can change
 `fsm.carryWith s0 env k` into `fsm.carryWith (env_bitstream_set env N val)`.
-/
theorem FSM.carryWith_congrEnv_envBitstream_set_of_le (fsm : FSM arity)
    (s0 : fsm.α → Bool) (env : arity → BitStream) (n : Nat) (v : arity → Bool)
    (k : Nat) (hk : k ≤ n) :
  fsm.carryWith s0 (envBitstream_set env n v) k =
  fsm.carryWith s0 env k := by
  apply FSM.carryWith_congrEnv
  intros a l hl
  simp [envBitstream_set]
  intros hcontra; omega


/--
There always exists a simple path of a given path,
which is shorter than the path, and ends at the same state.
Luckily, we don't care about this being executable or fast.
To ensure that we do not use the performance of this procedure,
we mark it `noncomputable`.
-/
noncomputable def mkSimplePathOfPath (fsm : FSM arity)
    (s0 : fsm.α → Bool) (n : Nat) (inputs : arity → BitStream) :
    SimplePathOfPath fsm s0 n inputs := by
  induction n
  case zero =>
   exact {
    simplePath := inputs,
    k := 0,
    hkLt := by omega,
    hCarryWith := rfl,
    hStatesUniqueLe := StatesUniqueLe_zero,
  }
  case succ n' path' =>
    -- let path' := mkSimplePathOfPath fsm s0 n' inputs
    let sn := fsm.carryWith s0 inputs (n' + 1)
    rcases hfind : (path'.findStateOnSimplePath? sn) with ⟨val, property⟩
    rcases val with rfl | k
    · exact {
      simplePath := envBitstream_set path'.simplePath (path'.k) (fun a => inputs a (n')),
      k := path'.k + 1,
      hkLt := by
        have := path'.hkLt
        omega,
      hCarryWith := by
        have := path'.hCarryWith
        conv =>
          lhs
          rw [← FSM.carryWith_carryWith_eq_carryWith_add]
          rw [this]
        conv =>
          rhs
          rw [← FSM.carryWith_carryWith_eq_carryWith_add]
        rw [FSM.carryWith_congrEnv_envBitstream_set_of_le]
        · generalize fsm.carryWith s0 path'.simplePath path'.k = s0'
          -- | TODO: find lemmas.
          ext a
          simp [FSM.carryWith, FSM.carry, FSM.nextBit,
            FSM.initCarry_changeInitCarry_eq, add_zero]
        · omega
      hStatesUniqueLe := by
        have := path'.hStatesUniqueLe
        simp [StatesUniqueLe] at this ⊢
        have hklt := path'.hkLt
        intros i j hi hj
        by_cases hj : j = path'.k + 1
        · subst hj
          clear hj
          have := SimplePathOfPath.findState?_eq_none_iff path' sn |>.mp (by simp [hfind])
          rw [FSM.carryWith_congrEnv_envBitstream_set_of_le]
          · specialize this i (by omega)
            have hsn : sn =
              fsm.carryWith s0 (envBitstream_set path'.simplePath path'.k fun a => inputs a n') (path'.k + 1) := by
              simp [sn]
              rw [← FSM.carryWith_carryWith_eq_carryWith_add]
              rw [← FSM.carryWith_carryWith_eq_carryWith_add]
              rw [FSM.carryWith_congrEnv_envBitstream_set_of_le]
              · rw [path'.hCarryWith]
                generalize fsm.carryWith s0 path'.simplePath path'.k = s0'
                ext a
                simp [FSM.carryWith, FSM.carry, FSM.nextBit,
                  FSM.initCarry_changeInitCarry_eq, add_zero]
              · omega
            rw [← hsn]
            apply this
          · omega
        · have hEnvI : fsm.carryWith s0 (envBitstream_set path'.simplePath path'.k (fun a => inputs a n')) i =
              fsm.carryWith s0 path'.simplePath i := by
            apply FSM.carryWith_congrEnv
            intros a k hk
            rw [envBitstream_set_eq_self_of_ne]
            omega
          have hEnvJ : fsm.carryWith s0 (envBitstream_set path'.simplePath path'.k (fun a => inputs a n')) j =
              fsm.carryWith s0 path'.simplePath j := by
            apply FSM.carryWith_congrEnv
            intros a k hk
            rw [envBitstream_set_eq_self_of_ne]
            omega
          rw [hEnvI, hEnvJ]
          apply this
          · omega
          · omega
      }
    case some =>
        -- let path' := mkSimplePathOfPath fsm s0 n' inputs
        -- let sn := fsm.carryWith s0 inputs (n' + 1)
        exact {
          simplePath := path'.simplePath,
          k := k,
          hkLt := by
            have := path'.hkLt
            specialize property k
            simp at property
            omega,
          hCarryWith := by
            have := path'.hCarryWith
            specialize property k
            simp at property
            obtain ⟨hk, hcarry, hfirst⟩ := property
            rw [hcarry],
          hStatesUniqueLe := by
            have := path'.hStatesUniqueLe
            simp [StatesUniqueLe] at this ⊢
            intros i j hi hj
            apply this
            · omega
            · specialize property k
              simp at property
              omega
        }

/-- Safety on all simple paths implies safety on all paths. -/
theorem evalWith_eq_false_of_evalWith_eq_false_of_StatesUniqueLe (fsm : FSM arity)
    (h : ∀ (inputs : _) (n : Nat),
      StatesUniqueLe fsm fsm.initCarry inputs n →
      fsm.evalWith fsm.initCarry inputs n = false)
    (n : Nat) (inputs : _) :
  fsm.evalWith fsm.initCarry inputs n = false := by
  have := mkSimplePathOfPath fsm fsm.initCarry n inputs
  simp [FSM.evalWith_eq_outputWith_carryWith]
  rw [FSM.carry_eq_carryWith_initCarry]
  rw [this.hCarryWith]
  simp [FSM.evalWith_eq_outputWith_carryWith] at h
  -- | make an 'env' that uses the input at 'k' to get the output.
  let env' := fun a i => if i = this.k then inputs a n else this.simplePath a i
  have hInputs : (fun a => inputs a n) = (fun a => env' a this.k) := by
    simp [env']
  rw [hInputs]
  rw [FSM.carryWith_congrEnv (y := env')]
  · rw [← FSM.evalWith_eq_outputWith_carryWith]
    apply h
    -- | TODO: need lemmas here.
    simp [StatesUniqueLe]
    intros i j hi hj
    have hUnique := this.hStatesUniqueLe
    simp [StatesUniqueLe] at hUnique
    specialize hUnique i j (by omega) (by omega)
    have hEnvI : fsm.carry env' i = fsm.carry this.simplePath i := by
      apply FSM.carry_congrEnv
      intros a l hl
      simp [env', show l ≠ this.k by omega]
    have hEnvJ : fsm.carry env' j = fsm.carry this.simplePath j := by
      apply FSM.carry_congrEnv
      intros a l hl
      simp [env', show l ≠ this.k by omega]
    rw [hEnvI, hEnvJ]
    apply hUnique
  · intros a k hk
    simp [env']
    intros hk'
    omega


/--
Evaluating at the created simple path equals evaluating at the original path.
-/
def SimplePathOfPath.hEvalWith (this : SimplePathOfPath fsm s0 (K + 1) env) :
    fsm.evalWith s0 env (K + 1) =
    fsm.evalWith s0
      (envBitstream_set this.simplePath (this.k) (fun a => env a (K + 1))) this.k := by
  rw [FSM.evalWith_eq_outputWith_carryWith]
  rw [FSM.evalWith_eq_outputWith_carryWith]
  rw [this.hCarryWith]
  rw [FSM.carryWith_congrEnv (y := envBitstream_set this.simplePath (this.k) (fun a => env a (K + 1)))]
  · congr
    ext i
    simp
  · intros a i hi
    rw [envBitstream_set_eq_self_of_ne (by omega)]

/--
If we have all unique states upto `K`, then we have unique states upto
`k' \leq K` on an `env'`, as long as `env` and `env'` match upto the required length.
-/
theorem StatesUniqueLe_of_StatesUniqueLe_congr
  {K k' : Nat}
  {fsm : FSM arity} {s0 : fsm.α → Bool}
  {env env' : arity → BitStream}
  {this : StatesUniqueLe fsm s0 env K}
  (hk' : k' ≤ K)
  (henv' : ∀ (a : arity) (i : Nat), i ≤ k' → env' a i = env a i) :
  StatesUniqueLe fsm s0 env' k' := by
  simp [StatesUniqueLe] at ⊢ this
  intros i j hii hj
  have hEnvI : fsm.carryWith s0 env' i = fsm.carryWith s0 env i := by
    apply FSM.carryWith_congrEnv
    intros a l hl
    apply henv'
    omega
  have hEnvJ : fsm.carryWith s0 env' j = fsm.carryWith s0 env j := by
    apply FSM.carryWith_congrEnv
    intros a l hl
    apply henv'
    omega
  rw [hEnvI, hEnvJ]
  apply this
  · omega
  · omega

axiom all_simple_paths_good_ax {p : Prop} : p

/-- Safety for all simple paths. -/
theorem all_simple_paths_good
    (fsm : FSM arity) (K : Nat)
    (hsafety : ∀ (i : Nat) (env : _) , i < K + 1 → fsm.evalWith fsm.initCarry env i = false)
    (hind : ∀ (s0 : _) (env : _),
       StatesUniqueLe fsm s0 env K →
       (∀ (i : Nat), i ≤ K  → fsm.evalWith s0 env i = false) →
        fsm.evalWith s0 env (K + 1) = false) :
  ∀ (env : _) (n : Nat),
    StatesUniqueLe fsm fsm.initCarry env n →
    fsm.evalWith fsm.initCarry env n = false
    := by
  intros envBitstream i
  induction i using Nat.strong_induction_on
  case h i hStrongI =>
    induction i using ind_principle₂ K
    case hBase i hi =>
      intros hPrecond
      apply hsafety
      omega
    case hInd j hjLt hjInd =>
      rw [show j = (j - (K + 1)) + (K + 1) by omega]
      rw [FSM.evalWith_add_eq_evalWith_carryWith]
      intros hUnique
      simp [show j - (K + 1) + (K + 1) = j by omega] at hUnique
      apply hind
      · intros k l hkl
        rw [FSM.carryWith_carryWith_eq_carryWith_add]
        rw [FSM.carryWith_carryWith_eq_carryWith_add]
        simp [StatesUniqueLe] at hUnique
        apply hUnique
        · omega
        · omega
      · -- rw [← FSM.evalWith_add_eq_evalWith_carryWith]
        intros i hi
        -- rw [show j - (K + 1) + i = j - (K + 1 - i) by omega]
        -- rw [show j - (K + 1 - i) = j - ((K - i)) - 1 by omega]
        by_cases hi : i = 0
        · subst hi
          simp
          apply hStrongI
          omega
          simp [StatesUniqueLe] at hUnique ⊢
          intros k l hk hl
          apply hUnique
          · omega
          · omega
        · rw [FSM.evalWith_eq_outputWith_carryWith]
          rw [FSM.carryWith_carryWith_eq_carryWith_add]
          rw [FSM.carryWith_congrEnv (y := envBitstream)]
          · rw [show j - (K + 1) + i = j - (K + 1 - i) by omega]
            rw [show j - (K + 1 - i) = j - ((K - i)) - 1 by omega]
            apply hjInd
            . omega
            . intros k hk; apply hStrongI; omega
            · simp [StatesUniqueLe] at hUnique ⊢
              intros k l hk hl
              apply hUnique
              · omega
              · omega
          · intros a k hk
            simp

/--
Safety for all paths, given that kinduction base case holds,
and that we can apply k-induction to simple paths.
-/
theorem all_paths_good_of_kbase_of_simple_path_kind
    (fsm : FSM arity) (K : Nat)
    (hsafety : ∀ (i : Nat) (env : _),
      i < K + 1 → fsm.evalWith fsm.initCarry env i = false)
    (hind : ∀ (s0 : _) (env : _),
      StatesUniqueLe fsm s0 env K →
      (∀ (i : Nat), i ≤ K → fsm.evalWith s0 env i = false) →
      fsm.evalWith s0 env (K + 1) = false) :
  ∀ (env : _) (n : Nat),
    fsm.evalWith fsm.initCarry env n = false := by
  intros env n
  apply evalWith_eq_false_of_evalWith_eq_false_of_StatesUniqueLe
  apply all_simple_paths_good (K := K)
  · apply hsafety
  · intros s0 env hUnique hindPrecond
    apply hind
    · apply hUnique
    · apply hindPrecond

/--
Safety on all paths, given that our evaluation of
`mkSafetyCircuit` is false, and `mkIndHypCycleBreaking` is false.
This is the theorem that is hooked to the external world.
-/
theorem eval_eq_false_of_mkIndHypCycleBreaking_eval_eq_false_of_mkSafetyCircuit_eval_eq_false
    (circs : KInductionCircuits fsm K)
    (hCircs : circs.IsLawful)
    (hSafety : ∀ (env : _), (mkSafetyCircuit circs).eval env = false)
    (hIndHyp : ∀ (env : _), (mkIndHypCycleBreaking circs).eval env = false) :
    (∀ (envBitstream : _), fsm.eval envBitstream i = false) := by
  intros envBitstream
  obtain hSafety := mkSafetyCircuit_eval_eq_false_thm hCircs hSafety
  obtain hIndHyp := mkIndHypCycleBreaking_eval_eq_false_thm hCircs hIndHyp
  apply all_paths_good_of_kbase_of_simple_path_kind (K :=  K)
  · intros k env hk
    apply hSafety
    omega
  · intros s0 env hUnique hind
    apply hIndHyp
    · apply hUnique
    · intros i hi
      apply hind
      omega

/--
The predicate `p` holds for all variables `vars`
if we can verify the safety circuit and the inductive hypothesis cycle breaking circuit.
-/
theorem Predicate.denote_of_verifyCircuit_mkSafetyCircuit_of_verifyCircuit_mkIndHypCycleBreaking
    (n : Nat)
    (p : Predicate)
    (w : Nat)
    (circs : KInductionCircuits (predicateEvalEqFSM p).toFSM n)
    (hCircs : circs.IsLawful)
    (vars : List (BitVec w))
    (sCert : BVDecide.Frontend.LratCert)
    (hs : Circuit.verifyCircuit (mkSafetyCircuit circs) sCert = true)
    (indCert : BVDecide.Frontend.LratCert)
    (hind : Circuit.verifyCircuit (mkIndHypCycleBreaking circs) indCert = true) :
    p.denote w vars := by
  apply Predicate.denote_of_eval
  rw [← Predicate.evalFin_eq_eval p
    (varsList := (List.map BitStream.ofBitVec vars))
    (varsFin := fun i => (List.map BitStream.ofBitVec vars).getD i default)]
  · rw [(predicateEvalEqFSM p).good]
    apply eval_eq_false_of_mkIndHypCycleBreaking_eval_eq_false_of_mkSafetyCircuit_eval_eq_false
      (circs := circs) (hCircs := hCircs)
    · apply Circuit.eval_eq_false_of_verifyCircuit
      exact hs
    · apply Circuit.eval_eq_false_of_verifyCircuit
      exact hind
  · intros i
    simp

/--
info: 'ReflectVerif.BvDecide.KInductionCircuits.Predicate.denote_of_verifyCircuit_mkSafetyCircuit_of_verifyCircuit_mkIndHypCycleBreaking' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
-/
#guard_msgs in #print axioms Predicate.denote_of_verifyCircuit_mkSafetyCircuit_of_verifyCircuit_mkIndHypCycleBreaking

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
/-- we have proven both the safety and inductive invariant property. -/
| provenByKIndCycleBreaking (numIters : Nat) (safetyCert : BVDecide.Frontend.LratCert) (indCertCycleBreaking : BVDecide.Frontend.LratCert)

namespace DecideIfZerosOutput
def isSuccess : DecideIfZerosOutput → Bool
  | .safetyFailure _ => false
  | .exhaustedIterations _ => false
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
    let safetyCert? ← Circuit.checkCircuitUnsatAux cSafety
    let tEnd ← IO.monoMsNow
    let tElapsedMs := (tEnd - tStart)
    trace[Bits.FastVerif] m!"Established safety property in {tElapsedMs}ms (iter={iter})."
    match safetyCert? with
    | .none =>
      trace[Bits.FastVerif] s!"Safety property failed on initial state."
      return (.safetyFailure iter, stats.push circs.stats)
    | .some safetyCert =>
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
      let indCert? ← Circuit.checkCircuitUnsatAux cIndHyp
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
  withTraceNode `trace.Bits.Fast (fun _ => return "k-induction") (collapsed := false) do
    -- logInfo m!"FSM state space size: {fsm.stateSpaceSize}"
    decideIfZerosAuxVerified' 0 maxIter fsm KInductionCircuits.mkZero #[]

end BvDecide

end ReflectVerif
