/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `grind_norm` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.AutoStructs.FormulaToAuto
import SSA.Experimental.Bits.FastCopy.Defs
import SSA.Experimental.Bits.FastCopy.Attr
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean

namespace Copy
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

open Lean in
def mkBoolLit (b : Bool) : Expr :=
  match b with
  | true => mkConst ``true
  | false => mkConst ``false

open Lean in
def Term.quote (t : Term) : Expr :=
  match t with
  | ofNat n => mkApp (mkConst ``Term.ofNat) (mkNatLit n)
  | var n => mkApp (mkConst ``Term.var) (mkNatLit n)
  | zero => mkConst ``Term.zero
  | one => mkConst ``Term.one
  | negOne => mkConst ``Term.negOne
-- | decr t => mkApp (mkConst ``Term.decr) (t.quote)
  -- | incr t => mkApp (mkConst ``Term.incr) (t.quote)
  | neg t => mkApp (mkConst ``Term.neg) (t.quote)
  | not t => mkApp (mkConst ``Term.not) (t.quote)
  | sub t₁ t₂ => mkApp2 (mkConst ``Term.sub) (t₁.quote) (t₂.quote)
  | add t₁ t₂ => mkApp2 (mkConst ``Term.add) (t₁.quote) (t₂.quote)
  | xor t₁ t₂ => mkApp2 (mkConst ``Term.xor) (t₁.quote) (t₂.quote)
  | or t₁ t₂ => mkApp2 (mkConst ``Term.or) (t₁.quote) (t₂.quote)
  | and t₁ t₂ => mkApp2 (mkConst ``Term.and) (t₁.quote) (t₂.quote)
  | shiftL t₁ n => mkApp2 (mkConst ``Term.shiftL) (t₁.quote) (mkNatLit n)

open Lean in
def mkConstBin (atp : Name) : Expr :=
  mkApp (mkConst ``Predicate.binary) (mkConst atp)

open Lean in
def Predicate.quote (p : Predicate) : Expr :=
  match p with
  | .width .eq n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.eq) (mkNatLit n)
  | .width .neq n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.neq) (mkNatLit n)
  | .width .lt n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.lt) (mkNatLit n)
  | .width .le n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.le) (mkNatLit n)
  | .width .gt n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.gt) (mkNatLit n)
  | .width .ge n => mkApp2 (mkConst ``Predicate.width) (mkConst ``WidthPredicate.ge) (mkNatLit n)
  | .binary .eq a b => mkApp2 (mkConstBin ``BinaryPredicate.eq) (Term.quote a) (Term.quote b)
  | .binary .neq a b => mkApp2 (mkConstBin ``BinaryPredicate.neq) (Term.quote a) (Term.quote b)
  | .binary .ult a b => mkApp2 (mkConstBin ``BinaryPredicate.ult) (Term.quote a) (Term.quote b)
  | .binary .ule a b => mkApp2 (mkConstBin ``BinaryPredicate.ule) (Term.quote a) (Term.quote b)
  | .binary .slt a b => mkApp2 (mkConstBin ``BinaryPredicate.slt) (Term.quote a) (Term.quote b)
  | .binary .sle a b => mkApp2 (mkConstBin ``BinaryPredicate.sle) (Term.quote a) (Term.quote b)
  | land p q => mkApp2 (mkConst ``Predicate.land) (Predicate.quote p) (Predicate.quote q)
  | lor p q => mkApp2 (mkConst ``Predicate.lor) (Predicate.quote p) (Predicate.quote q)

theorem _root_.BitVec.add_getLsbD_zero {x y : BitVec w} (hw : 0 < w) : (x + y).getLsbD 0 =
    ((x.getLsbD 0 ^^ y.getLsbD 0)) := by
  simp [hw, BitVec.getLsbD_add hw]

theorem _root_.BitVec.add_getLsbD_succ (x y : BitVec w) (hw : i + 1 < w) : (x + y).getLsbD (i + 1) =
    (x.getLsbD (i + 1) ^^ (y.getLsbD (i + 1)) ^^ BitVec.carry (i + 1) x y false) := by
  simp [hw, BitVec.getLsbD_add hw]

/-- TODO: simplify this proof, something too complex is going on here. -/
@[simp] theorem BitStream.toBitVec_add' (a b : BitStream) (w i : Nat) (hi : i < w) :
    ((a + b).toBitVec w).getLsbD i = ((a.toBitVec w) + (b.toBitVec w)).getLsbD i ∧
    (a.addAux b i).2 = (BitVec.carry (i + 1) (a.toBitVec w) (b.toBitVec w) false) := by
  simp [hi]
  rw [BitStream.add_eq_addAux]
  induction i
  case zero =>
    simp
    rw [BitVec.add_getLsbD_zero hi]
    simp [hi]
    simp [BitVec.carry_succ, hi]
  case succ i ih =>
    simp
    rw [BitVec.add_getLsbD_succ _ _ hi]
    have : i < w := by omega
    specialize ih this
    obtain ⟨ih₁, ih₂⟩ := ih
    rw [ih₂]
    simp [hi]
    rw [BitVec.carry_succ (i + 1)]
    simp [hi]

private theorem BitVec.lt_eq_decide_ult {x y : BitVec w} : (x < y) = decide (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult_toNat]

private theorem BitVec.lt_iff_ult {x y : BitVec w} : (x < y) ↔ (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult_toNat]

theorem eq_true_iff_of_eq_false_iff (b : Bool) (rhs : Prop) (h : (b = false) ↔ rhs) :
    (b = true) ↔ ¬ rhs := by
constructor
· intros h'
  apply h.not.mp
  simp [h']
· intros h'
  by_contra hcontra
  simp at hcontra
  have := h.mp hcontra
  exact h' this


/-- TODO: ForLean -/
private theorem BitVec.ForLean.ule_iff_ult_or_eq (x y : BitVec w) : x ≤ y ↔ (x = y ∨ x < y) := by
  constructor <;> bv_omega

private theorem BitVec.sle_iff_slt_or_eq (x y : BitVec w) : x.sle y ↔ (decide (x = y) ∨ x.slt y) := by
  simp [BitVec.slt, BitVec.sle]
  constructor
  · intros h
    suffices x.toInt = y.toInt ∨ x.toInt < y.toInt by
      rcases this with h | h
      · left
        apply BitVec.eq_of_toInt_eq h
      · right
        omega
    omega
  · intros h
    rcases h with rfl | h  <;> omega

/--
A predicate for a fixed width 'wn' can be expressed as universal quantification
over all width 'w', with a constraint that 'w = wn'
-/
theorem Predicate.width_eq_implies_iff (wn : Nat) {p : Nat → Prop} :
    p wn ↔ (∀ (w : Nat), w = wn → p w) := by
  constructor
  · intros hp h hwn
    subst hwn
    apply hp
  · intros hp
    apply hp
    rfl

def Reflect.Map.empty : List (BitVec w) := []

def Reflect.Map.append (w : Nat) (s : BitVec w)  (m : List (BitVec w)) : List (BitVec w) := m.append [s]

def Reflect.Map.get (ix : ℕ) (_ : BitVec w)  (m : List (BitVec w)) : BitVec w := m[ix]!

namespace Simplifications

/-!
Canonicalize `OfNat.ofNat`, `BitVec.ofNat` and `Nat` multiplication to become
`BitVec.ofNat` multiplication with constant on the left.
-/

attribute [bv_circuit_preprocess_copy] BitVec.ofNat_eq_ofNat

/-- Canonicalize multiplications by numerals. -/
@[bv_circuit_preprocess_copy] theorem BitVec.mul_nat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * n = BitVec.ofNat w n * x  := by rw [BitVec.mul_comm]; simp

/-- Canonicalize multiplications by numerals to have constants on the left,
with BitVec.ofNat -/
@[bv_circuit_preprocess_copy] theorem BitVec.nat_mul_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  n * x = BitVec.ofNat w n * x := by rfl

/-- Reassociate multiplication to move constants to left. -/
@[bv_circuit_preprocess_copy] theorem BitVec.mul_ofNat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * (BitVec.ofNat w n) = BitVec.ofNat w n * x := by rw [BitVec.mul_comm]


/-! Normal form for shifts

See that `x <<< (n : Nat)` is strictly more expression than `x <<< BitVec.ofNat w n`,
because in the former case, we can shift by arbitrary amounts, while in the latter case,
we can only shift by numbers upto `2^w`. Therefore, we choose `x <<< (n : Nat)` as our simp
and preprocessing normal form for the tactic.
-/

@[simp] theorem BitVec.shiftLeft_ofNat_eq (x : BitVec w) (n : Nat) :
  x <<< BitVec.ofNat w n = x <<< (n % 2^w) := by simp

/--
Multiplying by an even number `e` is the same as shifting by `1`,
followed by multiplying by half of `e` (the number `n`).
This is used to simplify multiplications into shifts.
-/
theorem BitVec.even_mul_eq_shiftLeft_mul_of_eq_mul_two (w : Nat) (x : BitVec w) (n e : Nat) (he : e = n * 2) :
    (BitVec.ofNat w e) * x = (BitVec.ofNat w n) * (x <<< (1 : Nat)) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, he]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · congr 1
    rw [Nat.mul_comm x.toNat 2, ← Nat.mul_assoc n]

/--
Multiplying by an odd number `o` is the same as adding `x`, followed by multiplying by `(o - 1) / 2`.
This is used to simplify multiplications into shifts.
-/
theorem BitVec.odd_mul_eq_shiftLeft_mul_of_eq_mul_two_add_one (w : Nat) (x : BitVec w) (n o : Nat)
    (ho : o = n * 2 + 1) : (BitVec.ofNat w o) * x = x + (BitVec.ofNat w n) * (x <<< (1 : Nat)) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, ho]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · congr 1
    rw [Nat.add_mul]
    simp only [one_mul]
    rw [Nat.mul_assoc, Nat.mul_comm 2]
    omega

@[bv_circuit_preprocess_copy] theorem BitVec.two_mul_eq_add_add (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq;
  simp only [BitVec.ofNat_eq_ofNat, BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod,
    BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess_copy] theorem BitVec.two_mul (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq
  simp only [BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod, BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess_copy] theorem BitVec.one_mul (x : BitVec w) : 1#w * x = x := by simp

@[bv_circuit_preprocess_copy] theorem BitVec.zero_mul (x : BitVec w) : 0#w * x = 0#w := by simp

-- @[bv_circuit_preprocess_copy] theorem BitVec.neg_one_mul (x : BitVec w) : -1#w * x = -x := by simp

@[bv_circuit_preprocess_copy] theorem BitVec.neg_mul (x y : BitVec w) : (- x) * y = -(x * y) := by simp


open Lean Meta Elab in

/--
Given an equality proof with `lhs = rhs`, return the `rhs`,
and bail out if we are unable to determine it precisely (i.e. no loose metavars).
-/
def getEqRhs (eq : Expr) : MetaM Expr := do
  check eq
  let eq ← whnf <| ← inferType eq
  let some (_ty, _lhs, rhs) := eq.eq? | throwError "unable to infer RHS for equality {eq}"
  let rhs ← instantiateMVars rhs
  rhs.ensureHasNoMVars
  return rhs

open Lean Meta Elab in
/--
This needs to be a pre-simproc, because we want to rewrite `k * x`
repeatedly into smaller multiplications:
  + rewrite into `x + ((k/2) * (x <<< 1))` if `k` odd.
  + rewrite into `(k/2) * (x <<< 1) if k even.

Since we get a smaller multiplication with `k/2`, we need it to be a pre-simproc so we recurse
into the RHS expression.
-/
simproc↓ [bv_circuit_preprocess_copy] shiftLeft_break_down ((BitVec.ofNat _ _) * (_ : BitVec _)) := fun x => do
  match_expr x with
  | HMul.hMul _bv _bv _bv _inst kbv x =>
    let_expr BitVec.ofNat _w k := kbv | return .continue
    let some kVal ← Meta.getNatValue? k | return .continue
    /- base cases, will be taken care of by rewrite theorems -/
    if kVal == 0 || kVal == 1 then return .continue
    let thmName := if kVal % 2 == 0 then
      mkConst ``BitVec.even_mul_eq_shiftLeft_mul_of_eq_mul_two
    else
      mkConst ``BitVec.odd_mul_eq_shiftLeft_mul_of_eq_mul_two_add_one
    let eqProof := mkAppN thmName
      #[_w, x, mkNatLit <| Nat.div2 kVal, mkNatLit kVal,  (← mkEqRefl k)]
    return .visit { proof? := eqProof, expr := ← getEqRhs eqProof }
  | _ => return .continue

open Lean Elab Meta
def runPreprocessing (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_circuit_preprocess_copy)
    | throwError m!"'bv_circuit_preprocess_copy' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_circuit_preprocess_copy)
    | throwError m!" 'bv_circuit_preprocess_copy' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let config : Simp.Config := { }
  let config := { config with failIfUnchanged := false }
  let ctx ← Simp.mkContext (config := config)
    (simpTheorems := #[theorems])
    (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

end Simplifications

namespace NNF

open Lean Elab Meta

/-- convert goal to negation normal form, by running appropriate lemmas from `grind_norm`, and reverting all hypothese. -/
def runNNFSimpSet (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `grind_norm)
    | throwError m!"[bv_nnf] Error: 'grind_norm' simp attribute not found!"
  let theorems ← ext.getTheorems
  let theorems ←  theorems.erase (Origin.decl ``ne_eq)
  let some ext ← (Simp.getSimprocExtension? `grind_norm)
    | throwError m!"[bv_nnf] Error: 'grind_norm' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let config : Simp.Config := { Simp.neutralConfig with
    failIfUnchanged   := false,
  }
  let ctx ← Simp.mkContext (config := config)
    (simpTheorems := #[theorems])
    (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

open Lean Elab Meta Tactic in
/-- Convert the goal into negation normal form. -/
elab "bv_nnf" : tactic => do
  liftMetaTactic fun g => do
    match ← runNNFSimpSet g with
    | none => return []
    | some g => do
      -- revert after running the simp-set, so that we don't transform
      -- with `forall_and : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x)`.
      -- TODO(@bollu): This opens up an interesting possibility, where we can handle smaller problems
      -- by just working on disjunctions.
      -- let g ← g.revertAll
      return [g]

attribute [grind_norm] BitVec.not_lt
attribute [grind_norm] BitVec.not_le

@[grind_norm]
theorem implies_eq_not_a_or_b (a b : Prop) : (a → b) = (¬ a ∨ b) := by
  by_cases a
  case pos h => simp [h]
  case neg h => simp [h]

@[grind_norm]
theorem sle_iff_slt_eq_false {a b : BitVec w} : a.slt b = false ↔ b.sle a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega

@[grind_norm]
theorem slt_iff_sle_eq_false {a b : BitVec w} : a.sle b = false ↔ b.slt a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega
--  ne_eq: (a ≠ b) = ¬(a = b) := rfl
attribute [- grind_norm] ne_eq -- TODO(bollu): Debate with grind maintainer about having `a ≠ b → ¬ (a = b)` in the simp-set?
@[grind_norm] theorem not_eq_iff_neq : (¬ (a = b)) = (a ≠ b) := by rfl

/--
warning: 'ne_eq' does not have [simp] attribute
---
warning: declaration uses 'sorry'
---
info: w : ℕ
⊢ (∀ (x x_1 : BitVec w), x_1 ≤ x) ∧ ∀ (x x_1 : BitVec w), x ≤ x_1 ∨ x_1 < x ∨ x ≤ x_1 ∨ x ≠ x_1
-/
#guard_msgs in example : ∀ (a b : BitVec w),  ¬ (a < b ∨ a > b ∧ a ≤ b ∧ a > b ∧ (¬ (a ≠ b))) := by
 bv_nnf; trace_state; sorry

/--
warning: 'ne_eq' does not have [simp] attribute
---
warning: declaration uses 'sorry'
---
info: w : ℕ
⊢ ∀ (a b : BitVec w), a &&& b ≠ 0#w ∨ a = b
-/
#guard_msgs in example : ∀ (a b : BitVec w), a &&& b = 0#w → a = b := by
 bv_nnf; trace_state; sorry

end NNF

/-
Armed with the above, we write a proof by reflection principle.
This is adapted from Bits/FastCopy/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

inductive AutomataBackend
| fast
| classic
deriving Repr, DecidableEq

inductive CircuitBackend
/-- Pure lean implementation, verified. -/
| lean (automata : AutomataBackend)
/-- bv_decide based backend. Currently unverified. -/
| cadical
/-- Dry run, do not execute and close proof with `sorry` -/
| dryrun
deriving Repr, DecidableEq

/-- Tactic options for bv_automata_circuit -/
structure Config where
  /--
  The upper bound on the size of circuits in the FSM, beyond which the tactic will bail out on an error.
  This is useful to prevent the tactic from taking oodles of time cruncing on goals that
  build large state spaces, which can happen in the presence of tactics.
  -/
  circuitSizeThreshold : Nat := 200

  /--
  The upper bound on the state space of the FSM, beyond which the tactic will bail out on an error.
  See also `Config.circuitSizeThreshold`.
  -/
  stateSpaceSizeThreshold : Nat := 20
  /--
  Whether the tactic should used a specialized solver for fixed-width constraints.
  -/
  fastFixedWidth : Bool := false
  /--
  Whether the tactic should use the (currently unverified) bv_decide based backend for solving constraints.
  -/
  backend : CircuitBackend := .lean .classic

/-- Default user configuration -/
def Config.default : Config := {}

/-- The free variables in the term that is reflected. -/
structure ReflectMap where
  /-- Map expressions to their index in the eventual `Reflect.Map`. -/
  exprs : Std.HashMap Expr Nat


instance : EmptyCollection ReflectMap where
  emptyCollection := { exprs := ∅ }

abbrev ReflectedExpr := Expr

/--
Insert expression 'e' into the reflection map. This returns the map,
as well as the denoted term.
-/
def ReflectMap.findOrInsertExpr (m : ReflectMap) (e : Expr) : Term × ReflectMap :=
  let (ix, m) := match m.exprs.get? e with
    | some ix =>  (ix, m)
    | none =>
      let ix := m.exprs.size
      (ix, { m with exprs := m.exprs.insert e ix })
  -- let e :=  mkApp (mkConst ``Term.var) (mkNatLit ix)
  (Term.var ix, m)


/--
Convert the meta-level `ReflectMap` into an object level `Reflect.Map` by
repeatedly calling `Reflect.Map.empty` and `Reflect.Map.set`.
-/
def ReflectMap.toExpr (xs : ReflectMap) (w : Expr) : MetaM ReflectedExpr := do
  let mut out := mkApp (mkConst ``Reflect.Map.empty) w
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.2 < ej.2)
  for (e, _) in exprs do
    -- The 'exprs' will be in order, with 0..n
    /- Append the expressions into the array -/
    out := mkAppN (mkConst ``Reflect.Map.append) #[w, e, out]
  return out

instance : ToMessageData ReflectMap where
  toMessageData exprs := Id.run do
    -- sort in order of index.
    let es := exprs.exprs.toArray.qsort (fun a b => a.2 < b.2)
    let mut lines := es.map (fun (e, i) => m!"{i}→{e}")
    return m!"[" ++ m!" ".joinSep lines.toList ++ m!"]"

/--
If we have variables in the `ReflectMap` that are not FVars,
then we will throw a warning informing the user that this will be treated as a symbolic variable.
-/
def ReflectMap.throwWarningIfUninterpretedExprs (xs : ReflectMap) : MetaM Unit := do
  let mut out? : Option MessageData := none
  let header := m!"Tactic has not understood the following expressions, and will treat them as symbolic:"
  -- Order the expressions so we get stable error messages.
  let exprs := xs.exprs.toArray.qsort (fun ei ej => ei.1.lt ej.1)

  for (e, _) in exprs do
    if e.isFVar then continue
    let eshow := indentD m!"- '{e}'"
    out? := match out? with
      | .none => header ++ Format.line ++ eshow
      | .some out => .some (out ++ eshow)
  let .some out := out? | return ()
  logWarning out

/--
Result of reflection, where we have a collection of bitvector variables,
along with the bitwidth and the final term.
-/
structure ReflectResult (α : Type) where
  /-- Map of 'free variables' in the bitvector expression,
  which are indexed as Term.var. This array is used to build the environment for decide.
  -/
  bvToIxMap : ReflectMap
  e : α

instance [ToMessageData α] : ToMessageData (ReflectResult α) where
  toMessageData result := m!"{result.e} {result.bvToIxMap}"



/--
info: ∀ {w : Nat} (a b : BitVec w),
  @Eq (BitVec w) (@HAdd.hAdd (BitVec w) (BitVec w) (BitVec w) (@instHAdd (BitVec w) (@BitVec.instAdd w)) a b)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a b: BitVec w), a + b = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq (BitVec w) (@Neg.neg (BitVec w) (@BitVec.instNeg w) a)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w), - a = 0#w

/--
info: ∀ {w : Nat} (a : BitVec w) (n : Nat),
  @Eq (BitVec w) (@HShiftLeft.hShiftLeft (BitVec w) Nat (BitVec w) (@BitVec.instHShiftLeftNat w) a n)
    (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w) (n : Nat), a <<< n = 0#w


/--
info: ∀ {w : Nat} (a : BitVec w),
  @LT.lt (BitVec w) (@instLTBitVec w) a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  < 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @LE.le (BitVec w) (@instLEBitVec w) a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0))) : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a  ≤ 0#w

/--
info: ∀ {w : Nat} (a : BitVec w),
  @Eq Bool (@BitVec.slt w a (BitVec.ofNat w (@OfNat.ofNat Nat 0 (instOfNatNat 0)))) true : Prop
-/
#guard_msgs in set_option pp.explicit true in
#check ∀ {w : Nat} (a : BitVec w),  a.slt 0#w


def reflectAtomUnchecked (map : ReflectMap) (_w : Expr) (e : Expr) : MetaM (ReflectResult Term) := do
  let (e, map) := map.findOrInsertExpr e
  return { bvToIxMap := map, e := e }


/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
partial def reflectTermUnchecked (map : ReflectMap) (w : Expr) (e : Expr) : MetaM (ReflectResult Term) := do
  if let some (v, _bvTy) ← getOfNatValue? e ``BitVec then
    return { bvToIxMap := map, e := Term.ofNat v }
  -- TODO: bitvector contants.
  match_expr e with
  | BitVec.ofInt _wExpr iExpr =>
    let i ← getIntValue? iExpr
    match i with
    | _ =>
      let (e, map) := map.findOrInsertExpr e
      return { bvToIxMap := map, e := e }
  | BitVec.ofNat _wExpr nExpr =>
    let n ← getNatValue? nExpr
    match n with
    | .some 0 =>
      return {bvToIxMap := map, e := Term.zero }
    | .some 1 =>
      let _ := (mkConst ``Term.one)
      return {bvToIxMap := map, e := Term.one }
    | .some n =>
      return { bvToIxMap := map, e := Term.ofNat n }
    | none =>
      logWarning "expected concrete BitVec.ofNat, found symbol '{n}', creating free variable"
      reflectAtomUnchecked map w e

  | HAnd.hAnd _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.and a.e b.e
      return { b with e := out }
  | HOr.hOr _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.or a.e b.e
      return { b with e := out }
  | HXor.hXor _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.xor a.e b.e
      return { b with e := out }
  | Complement.complement _bv _inst a =>
      let a ← reflectTermUnchecked map w a
      let out := Term.not a.e
      return { a with e := out }
  | HAdd.hAdd _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.add a.e b.e
      return { b with e := out }
  | HShiftLeft.hShiftLeft _bv _nat _bv _inst a n =>
      let a ← reflectTermUnchecked map w a
      let some n ← getNatValue? n
        | throwError "expected shiftLeft by natural number, found symbolic shift amount '{n}' at '{indentD e}'"
      return { a with e := Term.shiftL a.e n }

  | HSub.hSub _bv _bv _bv _inst a b =>
      let a ← reflectTermUnchecked map w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      let out := Term.sub a.e b.e
      return { b with e := out }
  | Neg.neg _bv _inst a =>
      let a ← reflectTermUnchecked map w a
      let out := Term.neg a.e
      return { a with e := out }
  -- incr
  -- decr
  | _ =>
    let (e, map) := map.findOrInsertExpr e
    return { bvToIxMap := map, e := e }

set_option pp.explicit true in
/--
info: ∀ {w : Nat} (a b : BitVec w), Or (@Eq (BitVec w) a b) (And (@Ne (BitVec w) a b) (@Eq (BitVec w) a b)) : Prop
-/
#guard_msgs in
#check ∀ {w : Nat} (a b : BitVec w), a = b ∨ (a ≠ b) ∧ a = b

/-- Return a new expression that this is defeq to, along with the expression of the environment that this needs, under which it will be defeq. -/
partial def reflectPredicateAux (bvToIxMap : ReflectMap) (e : Expr) (wExpected : Expr) : MetaM (ReflectResult Predicate) := do
  match_expr e with
  | Eq α a b =>
    match_expr α with
    | Nat =>
       -- support width equality constraints
      -- TODO: canonicalize 'a = w' into 'w = a'.
      if wExpected != a then
        throwError "Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError "Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.width .eq natVal
      return { bvToIxMap := bvToIxMap, e := out }

    | BitVec w =>
      let a ←  reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .eq a.e b.e }
    | Bool =>
      -- Sadly, recall that slt, sle are of type 'BitVec w → BitVec w → Bool',
      -- so we get goal states of them form 'a <ₛb = true'.
      -- So we need to match on 'Eq _ true' where '_' is 'slt'.
      -- This makes me unhappy too, but c'est la vie.
      let_expr true := b
        | throwError "only boolean conditionals allowed are 'bv.slt bv = true', 'bv.sle bv = true'. Found {indentD e}."
      match_expr a with
      | BitVec.slt w a b =>
        let a ← reflectTermUnchecked bvToIxMap w a
        let b ← reflectTermUnchecked a.bvToIxMap w b
        return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .slt a.e b.e }
      | BitVec.sle w a b =>
        let a ← reflectTermUnchecked bvToIxMap w a
        let b ← reflectTermUnchecked a.bvToIxMap w b
        return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .sle a.e b.e }
      | _ =>
        throwError "unknown boolean conditional, expected 'bv.slt bv = true' or 'bv.sle bv = true'. Found {indentD e}"
    | _ =>
      throwError "unknown equality kind, expected 'bv = bv' or 'bv.slt bv = true' or 'bv.sle bv = true'. Found {indentD e}"
  | Ne α a b =>
    /- Support width constraints with α = Nat -/
    match_expr α with
    | Nat => do
      -- TODO: canonicalize 'a ≠ w' into 'w ≠ a'.
      if wExpected != a then
        throwError "Only Nat expressions allowed are '{wExpected} ≠ <concrete value>'. Found {indentD e}."
      let some natVal ← Lean.Meta.getNatValue? b
        | throwError "Expected '{wExpected} ≠ <concrete width>', found symbolic width {indentD b}."
      let out := Predicate.width .neq natVal
      return { bvToIxMap := bvToIxMap, e := out }
    | BitVec w =>
      let a ← reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .neq a.e b.e }
    | _ =>
      throwError "Expected typeclass to be 'BitVec w' / 'Nat', found '{indentD α}' in {e} when matching against 'Ne'"
  | LT.lt α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LT.lt'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ult a.e b.e }
  | LE.le α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LE.le'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.binary .ule a.e b.e }
  | Or p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.lor p.e q.e
    return { q with e := out }
  | And p q =>
    let p ← reflectPredicateAux bvToIxMap p wExpected
    let q ← reflectPredicateAux p.bvToIxMap q wExpected
    let out := Predicate.land p.e q.e
    return { q with e := out }
  | _ =>
     throwError "expected predicate over bitvectors (no quantification), found:  {indentD e}"

/-- Name of the tactic -/
def tacName : String := "bv_automata_circuit"

abbrev WidthToExprMap := Std.HashMap Expr Expr

/--
Find all bitwidths implicated in the given expression.
Maps each length (the key) to an expression of that length.

Find all bitwidths implicated in the given expression,
by visiting subexpressions with visitExpr:
    O(size of expr × inferType)
-/
def findExprBitwidths (target : Expr) : MetaM WidthToExprMap := do
  let (_, out) ← StateT.run (go target) ∅
  return out
  where
    go (target : Expr) : StateT WidthToExprMap MetaM Unit := do
      -- Creates fvars when going inside binders.
      forEachExpr target fun e => do
        match_expr ← inferType e with
        | BitVec n =>
          -- TODO(@bollu): do we decide to normalize `n`? upto what?
          modify (fun arr => arr.insert n.cleanupAnnotations e)
        | _ => return ()

/-- Return if expression 'e' is a bitvector of bitwidth 'w' -/
private def Expr.isBitVecOfWidth (e : Expr) (w : Expr) : MetaM Bool := do
  match_expr ← inferType e with
  | BitVec w' => return w == w'
  | _ => return false


/-- Revert all bitwidths of a given bitwidth and then run the continuation 'k'.
This allows
-/
def revertBVsOfWidth (g : MVarId) (w : Expr) : MetaM MVarId := g.withContext do
  let mut reverts : Array FVarId := #[]
  for d in ← getLCtx do
    if ← Expr.isBitVecOfWidth d.type w then
      reverts := reverts.push d.fvarId
  /- revert all the bitvectors of the given width in one fell swoop. -/
  let (_fvars, g) ← g.revert reverts
  return g

/-- generalize our mapping to get a single fvar -/
def generalizeMap (g : MVarId) (e : Expr) : MetaM (FVarId × MVarId) :=  do
  let (fvars, g) ← g.generalize #[{ expr := e : GeneralizeArg}]
  --eNow target no longer depends on the particular bitvectors
  if h : fvars.size = 1 then
    return (fvars[0], g)
  throwError"expected a single free variable from generalizing map {e}, found multiple..."

/--
Revert all hypotheses that have to do with bitvectors, so that we can use them.

For now, we choose to revert all propositional hypotheses.
The issue is as follows: Since our reflection fragment only deals with
goals in negation normal form, the naive algorithm would run an NNF pass
and then try to reflect the hyp before reverting it. This is expensive and annoying to implement.

Ideally, we would have a pass that quickly walks an expression to cheaply
ee if it's in the BV fragment, and revert it if it is.
For now, we use a sound overapproximation and revert everything.
-/
def revertBvHyps (g : MVarId) : MetaM MVarId := do
  let (_, g) ← g.revert (← g.getNondepPropHyps)
  return g


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
def reflectUniversalWidthBVs (g : MVarId) (cfg : Config) : TermElabM (List MVarId) := do
  let ws ← findExprBitwidths (← g.getType)
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
    let g ← revertBvHyps g

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
    let result ← reflectPredicateAux ∅ (← g.getType) w
    result.bvToIxMap.throwWarningIfUninterpretedExprs

    logInfo m!"predicate (repr): {indentD (repr result.e)}"

    let bvToIxMapVal ← result.bvToIxMap.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    logInfo m!"goal after reflection: {indentD g}"

    match cfg.backend with
    | .dryrun =>
        g.assign (← mkSorry (← g.getType) (synthetic := false))
        logInfo "Closing goal with 'sorry' for dry-run"
        return []
    | .cadical =>
      return []
    | .lean .fast =>
      return []
    | .lean .classic =>
      let (mapFv, g) ← generalizeMap g bvToIxMapVal;
      let (_, g) ← g.revert #[mapFv]
      -- Apply Predicate.denote_of_eval_eq.
      let wVal? ← Meta.getNatValue? w
      let g ←
        -- TODO FIXME
        if false then
          pure g
        else
          -- Generic width problem.
          -- If the generic width problem has as 'complex' width, then warn the user that they're
          -- trying to solve a fragment that's better expressed differently.
          if !w.isFVar then
            let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
            let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
            let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
            logWarning  msg

          let [g] ← g.apply <| (mkConst ``Formula.denote_of_isUniversal)
            | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
          pure g
      let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
        | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
      return [g]

/-- Allow elaboration of `bv_automata_circuit's config` arguments to tactics. -/
declare_config_elab elabBvAutomataCircuitConfig Config

syntax (name := bvAutomataCircuit) "bv_automata_classic_nf" (Lean.Parser.Tactic.config)? : tactic
@[tactic bvAutomataCircuit]
def evalBvAutomataCircuit : Tactic := fun
| `(tactic| bv_automata_classic_nf $[$cfg]?) => do
  let cfg ← elabBvAutomataCircuitConfig (mkOptionalNode cfg)
  let g ← getMainGoal
  g.withContext do
    let gs ← reflectUniversalWidthBVs g cfg
    replaceMainGoal gs
    match gs  with
    | [] => return ()
    | [g] => do
      logInfo m!"goal being decided via boolean reflection: {indentD g}"
      evalDecideCore `bv_automata_circuit (cfg := { native := true : Parser.Tactic.DecideConfig })
    | _gs => throwError "expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax

end Reflect
