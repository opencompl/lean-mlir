/-
Released under Apache 2.0 license as described in the file LICENSE.
This file reflects the semantics of bitstreams, terms, predicates, and FSMs
into lean bitvectors.

We use `grind_norm` to convert the expression into negation normal form.

Authors: Siddharth Bhat
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.Fast.Defs
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Fast.Attr
import SSA.Experimental.Bits.Fast.Decide
import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean

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
- [ ] Break down numeral multiplication into left shift:
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
- [ ] `signExtend` and `zeroExtend` support.

- [ ] Write custom fast decision procedure for constant widths.

-/

/--
Denote a bitstream into the underlying bitvector.
-/
def BitStream.denote (s : BitStream) (w : Nat) : BitVec w := s.toBitVec w

@[simp] theorem BitStream.denote_zero : BitStream.denote BitStream.zero w = 0#w := by
  simp [denote, toBitVec]
  sorry

@[simp] theorem BitStream.denote_negOne : BitStream.denote BitStream.negOne w = BitVec.allOnes w := by
  simp [denote, toBitVec]
  sorry

open Lean in
def mkBoolLit (b : Bool) : Expr :=
  match b with
  | true => mkConst ``true
  | false => mkConst ``false

open Lean in
def Term.quote (t : _root_.Term) : Expr :=
  match t with
  | ofNat n => mkApp (mkConst ``Term.ofNat) (mkNatLit n)
  | var n => mkApp (mkConst ``Term.var) (mkNatLit n)
  | zero => mkConst ``Term.zero
  | one => mkConst ``Term.one
  | negOne => mkConst ``Term.negOne
  | decr t => mkApp (mkConst ``Term.decr) (t.quote)
  | incr t => mkApp (mkConst ``Term.incr) (t.quote)
  | neg t => mkApp (mkConst ``Term.neg) (t.quote)
  | not t => mkApp (mkConst ``Term.not) (t.quote)
  | ls b t => mkApp2 (mkConst ``Term.ls) (mkBoolLit b) (t.quote)
  | sub t₁ t₂ => mkApp2 (mkConst ``Term.sub) (t₁.quote) (t₂.quote)
  | add t₁ t₂ => mkApp2 (mkConst ``Term.add) (t₁.quote) (t₂.quote)
  | xor t₁ t₂ => mkApp2 (mkConst ``Term.xor) (t₁.quote) (t₂.quote)
  | or t₁ t₂ => mkApp2 (mkConst ``Term.or) (t₁.quote) (t₂.quote)
  | and t₁ t₂ => mkApp2 (mkConst ``Term.and) (t₁.quote) (t₂.quote)
  | shiftL t₁ n => mkApp2 (mkConst ``Term.shiftL) (t₁.quote) (mkNatLit n)

open Lean in
def Predicate.quote (p : _root_.Predicate) : Expr :=
  match p with
  | widthEq n => mkApp (mkConst ``Predicate.widthEq) (mkNatLit n)
  | widthNeq n => mkApp (mkConst ``Predicate.widthNeq) (mkNatLit n)
  | widthLt n => mkApp (mkConst ``Predicate.widthLt) (mkNatLit n)
  | widthLe n => mkApp (mkConst ``Predicate.widthLe) (mkNatLit n)
  | widthGt n => mkApp (mkConst ``Predicate.widthGt) (mkNatLit n)
  | widthGe n => mkApp (mkConst ``Predicate.widthGe) (mkNatLit n)
  | eq a b => mkApp2 (mkConst ``Predicate.eq) (_root_.Term.quote a) (_root_.Term.quote b)
  | neq a b => mkApp2 (mkConst ``Predicate.neq) (_root_.Term.quote a) (_root_.Term.quote b)
  | ult a b => mkApp2 (mkConst ``Predicate.ult) (_root_.Term.quote a) (_root_.Term.quote b)
  | ule a b => mkApp2 (mkConst ``Predicate.ule) (_root_.Term.quote a) (_root_.Term.quote b)
  | slt a b => mkApp2 (mkConst ``Predicate.slt) (_root_.Term.quote a) (_root_.Term.quote b)
  | sle a b => mkApp2 (mkConst ``Predicate.sle) (_root_.Term.quote a) (_root_.Term.quote b)
  | land p q => mkApp2 (mkConst ``Predicate.land) (Predicate.quote p) (Predicate.quote q)
  | lor p q => mkApp2 (mkConst ``Predicate.lor) (Predicate.quote p) (Predicate.quote q)

/-- Denote a Term into its underlying bitvector -/
def Term.denote (w : Nat) (t : Term) (vars : List (BitVec w)) : BitVec w :=
  match t with
  | ofNat n => BitVec.ofNat w n
  | var n => vars[n]!
  | zero => 0#w
  | negOne => BitVec.ofInt w (-1)
  | one  => 1#w
  | and a b => (a.denote w vars) &&& (b.denote w vars)
  | or a b => (a.denote w vars) ||| (b.denote w vars)
  | xor a b => (a.denote w vars) ^^^ (b.denote w vars)
  | not a => ~~~ (a.denote w vars)
  | add a b => (a.denote w vars) + (b.denote w vars)
  | sub a b => (a.denote w vars) - (b.denote w vars)
  | neg a => - (a.denote w vars)
  | incr a => (a.denote w vars) + 1#w
  | decr a => (a.denote w vars) - 1#w
  | ls bit a => (a.denote w vars).shiftConcat bit
  | shiftL a n => (a.denote w vars) <<< n

theorem Term.eval_eq_denote (t : Term) (w : Nat) (vars : List (BitVec w)) :
    (t.eval (vars.map BitStream.ofBitVec)).denote w = t.denote w vars := by
  induction t generalizing w vars
  repeat sorry

def Predicate.denote (p : Predicate) (w : Nat) (vars : List (BitVec w)) : Prop :=
  match p with
  | .widthGe k => k ≤ w -- w ≥ k
  | .widthGt k => k < w -- w > k
  | .widthLe k => w ≤ k
  | .widthLt k => w < k
  | .widthNeq k => w ≠ k
  | .widthEq k => w = k
  | .eq t₁ t₂ => t₁.denote w vars = t₂.denote w vars
  | .neq t₁ t₂ => t₁.denote w vars ≠ t₂.denote w vars
  | .land  p q => p.denote w vars ∧ q.denote w vars
  | .lor  p q => p.denote w vars ∨ q.denote w vars
  | .sle  t₁ t₂ => (((t₁.denote w vars).sle (t₂.denote w vars)) = true)
  | .slt  t₁ t₂ => ((t₁.denote w vars).slt (t₂.denote w vars)) = true
  | .ule  t₁ t₂ => ((t₁.denote w vars) ≤ (t₂.denote w vars))
  | .ult  t₁ t₂ => (t₁.denote w vars) < (t₂.denote w vars)

/--
The cost model of the predicate, which is based on the cardinality of the state space,
and the size of the circuits.
-/
def Predicate.cost (p : Predicate) : Nat :=
  let fsm := predicateEvalEqFSM p
  fsm.circuitSize

/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : List (BitVec w)) :
    (p.eval (vars.map BitStream.ofBitVec) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  repeat sorry

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

/-- To prove that `p` holds, it suffices to show that `p.eval ... = false`. -/
theorem Predicate.denote_of_eval_eq {p : Predicate}
    (heval : ∀ (w : Nat) (vars : List BitStream), p.eval vars w = false) :
    ∀ (w : Nat) (vars : List (BitVec w)), p.denote w vars := by
  intros w vars
  apply p.eval_eq_denote w vars |>.mp (heval w <| vars.map BitStream.ofBitVec)


def Reflect.Map.empty : List (BitVec w) := []

def Reflect.Map.append (w : Nat) (s : BitVec w)  (m : List (BitVec w)) : List (BitVec w) := m.append [s]

def Reflect.Map.get (ix : ℕ) (_ : BitVec w)  (m : List (BitVec w)) : BitVec w := m[ix]!

namespace Simplifications

/-!
Canonicalize `OfNat.ofNat`, `BitVec.ofNat` and `Nat` multiplication to become
`BitVec.ofNat` multiplication with constant on the left.
-/

attribute [bv_circuit_preprocess] BitVec.ofNat_eq_ofNat

/-- Canonicalize multiplications by numerals. -/
@[bv_circuit_preprocess] theorem BitVec.mul_nat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * n = BitVec.ofNat w n * x  := by rw [BitVec.mul_comm]; simp

/-- Canonicalize multiplications by numerals to have constants on the left,
with BitVec.ofNat -/
@[bv_circuit_preprocess] theorem BitVec.nat_mul_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  n * x = BitVec.ofNat w n * x := by rfl

/-- Reassociate multiplication to move constants to left. -/
@[bv_circuit_preprocess] theorem BitVec.mul_ofNat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * (BitVec.ofNat w n) = BitVec.ofNat w n * x := by rw [BitVec.mul_comm]


/--
Multiplying by an even number `e` is the same as shifting by `1`,
followed by multiplying by half of `e` (the number `n`).
This is used to simplify multiplications into shifts.
-/
theorem BitVec.even_mul_eq_shiftLeft_mul_of_eq_mul_two (x : BitVec w) (n e : Nat) (he : e = n * 2) :
    (BitVec.ofNat w e) * x = (BitVec.ofNat w n) * (x <<< 1) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, he]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · simp
    congr 1
    rw [Nat.mul_comm x.toNat 2, ← Nat.mul_assoc n]

/--
Multiplying by an odd number `o` is the same as adding `x`, followed by multiplying by `(o - 1) / 2`.
This is used to simplify multiplications into shifts.
-/
theorem BitVec.odd_mul_eq_shiftLeft_mul_of_eq_mul_two_add_one (x : BitVec w) (n o : Nat)
    (ho : o = n * 2 + 1) : (BitVec.ofNat w o) * x = x + (BitVec.ofNat w n) * (x <<< 1) := by
  apply BitVec.eq_of_toNat_eq
  simp [Nat.shiftLeft_eq, ho]
  rcases w with rfl | w
  · simp [Nat.mod_one]
  · simp only [lt_add_iff_pos_left, add_pos_iff, zero_lt_one, or_true, Nat.one_mod_two_pow,
    pow_one]
    congr 1
    rw [Nat.add_mul]
    simp only [one_mul]
    rw [Nat.mul_assoc, Nat.mul_comm 2]
    omega

@[bv_circuit_preprocess] theorem BitVec.two_mul_eq_add_add (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq;
  simp only [BitVec.ofNat_eq_ofNat, BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod,
    BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess] theorem BitVec.two_mul (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq
  simp only [BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod, BitVec.toNat_add]
  congr
  omega

@[bv_circuit_preprocess] theorem BitVec.one_mul (x : BitVec w) : 1#w * x = x := by simp

@[bv_circuit_preprocess] theorem BitVec.zero_mul (x : BitVec w) : 0#w * x = 0#w := by simp

open Lean Elab Meta
def runPreprocessing (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_circuit_preprocess)
    | throwError m!"'bv_circuit_preprocess' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_circuit_preprocess)
    | throwError m!" 'bv_circuit_preprocess' simp attribute not found!"
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
This is adapted from Bits/Fast/Tactic.lean, but is cleaned up to build 'nice' looking environments
for reflection, rather than ones based on hashing the 'fvar', which can also have weird corner cases due to hash collisions.

TODO(@bollu): For now, we don't reflects constants properly, since we don't have arbitrary constants in the term language (`Term`).
TODO(@bollu): We also assume that the goals are in negation normal form, and if we not, we bail out. We should make sure that we write a tactic called `nnf` that transforms goals to negation normal form.
-/

namespace Reflect
open Lean Meta Elab Tactic

/-- Tactic options for bv_automata_circuit -/
structure Config where
  /--
  The upper bound on the size of circuits in the FSM, beyond which the tactic will bail out on an error.
  This is useful to prevent the tactic from taking oodles of time cruncing on goals that
  build large state spaces, which can happen in the presence of tactics.
  -/
  circuitSizeThreshold : Nat := 90

  /--
  The upper bound on the state space of the FSM, beyond which the tactic will bail out on an error.
  See also `Config.circuitSizeThreshold`.
  -/
  stateSpaceSizeThreshold : Nat := 20

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
def ReflectMap.findOrInsertExpr (m : ReflectMap) (e : Expr) : _root_.Term × ReflectMap :=
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
    let eshow := indentD m!"- {e}"
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


def reflectAtomUnchecked (map : ReflectMap) (_w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  let (e, map) := map.findOrInsertExpr e
  return { bvToIxMap := map, e := e }


/--
Return a new expression that this is **defeq** to, along with the expression of the environment that this needs.
Crucially, when this succeeds, this will be in terms of `term`.
and furthermore, it will reflect all terms as variables.

Precondition: we assume that this is called on bitvectors.
-/
partial def reflectTermUnchecked (map : ReflectMap) (w : Expr) (e : Expr) : MetaM (ReflectResult _root_.Term) := do
  if let some (v, _bvTy) ← getOfNatValue? e ``BitVec then
    return { bvToIxMap := map, e := Term.ofNat v }
  -- TODO: bitvector contants.
  match_expr e with
  | BitVec.ofInt _wExpr iExpr =>
    let i ← getIntValue? iExpr
    match i with
    | .some (-1) =>
      return {bvToIxMap := map, e := Term.negOne }
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
      let some natVal ← Lean.Meta.getNatValue? n
        | throwError "Only shift left by natural numbers are allowed, but found shift by expression '{n}' at {indentD e}"
      return { a with e := Term.shiftL a.e natVal }
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
    | BitVec w =>
      let a ←  reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.eq a.e b.e }
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
        return { bvToIxMap := b.bvToIxMap, e := Predicate.slt a.e b.e }
      | BitVec.sle w a b =>
        let a ← reflectTermUnchecked bvToIxMap w a
        let b ← reflectTermUnchecked a.bvToIxMap w b
        return { bvToIxMap := b.bvToIxMap, e := Predicate.sle a.e b.e }
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
      let out := Predicate.widthNeq natVal
      return { bvToIxMap := bvToIxMap, e := out }
    | BitVec w =>
      let a ← reflectTermUnchecked bvToIxMap w a
      let b ← reflectTermUnchecked a.bvToIxMap w b
      return { bvToIxMap := b.bvToIxMap, e := Predicate.neq a.e b.e }
    | _ =>
      throwError "Expected typeclass to be 'BitVec w' / 'Nat', found '{indentD α}' in {e} when matching against 'Ne'"
  | LT.lt α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LT.lt'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.ult a.e b.e }
  | LE.le α _inst a b =>
    let_expr BitVec w := α | throwError "Expected typeclass to be BitVec w, found '{indentD α}' in {indentD e} when matching against 'LE.le'"
    let a ← reflectTermUnchecked bvToIxMap w a
    let b ← reflectTermUnchecked a.bvToIxMap w b
    return { bvToIxMap := b.bvToIxMap, e := Predicate.ule a.e b.e }
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
def reflectUniversalWidthBVs (g : MVarId) (cfg : Config) : MetaM (List MVarId) := do
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

    -- Interesting, tobias was right.
    -- @bollu: I can 'generalize' and solve the '∀ w ... ' problem, and then 're-specialize' back to 'w = k'
    -- for fixed k. I think this loses some power as opposed to having a width constraint.
      if !w.isFVar then
        let msg := m!"Width '{w}' is not a free variable (i.e. width is not universally quantified)."
        let msg := msg ++ Format.line ++ m!"The tactic will perform width-generic reasoning."
        let msg := msg ++ Format.line ++ m!"To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = {w}), ..."
        logWarning  msg
        -- let g ← g.assertExt (name := `w') (type := mkConst ``Nat) (val := w) (hName := `hw')
        -- let (w', g) ← g.intro1P
        -- let (hw', g) ← g.intro1P
        -- g.withContext do logInfo m!"Added new constraint for width (to be abstracted): {← hw'.getType}"
        pure g
      else pure g

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

    let bvToIxMapVal ← result.bvToIxMap.toExpr w

    let target := (mkAppN (mkConst ``Predicate.denote) #[result.e.quote, w, bvToIxMapVal])
    let g ← g.replaceTargetDefEq target
    logInfo m!"goal after reflection: {indentD g}"

    -- Log the finite state machine size, and bail out if we cross the barrier.
    let fsm := predicateEvalEqFSM result.e |>.toFSM
    logInfo m!"FSM: ⋆Circuit size '{toMessageData fsm.circuitSize}'  ⋆State space size '{fsm.stateSpaceSize}'"
    if fsm.circuitSize > cfg.circuitSizeThreshold then
      throwError "Not running on goal: since circuit size ('{fsm.circuitSize}') is larger than threshold ('circuitSizeThreshold:{cfg.circuitSizeThreshold}')"
    if fsm.stateSpaceSize > cfg.stateSpaceSizeThreshold then
      throwError "Not running on goal: since state space size size ('{fsm.stateSpaceSize}') is larger than threshold ('stateSpaceSizeThreshold:{cfg.stateSpaceSizeThreshold}')"

    let (mapFv, g) ← generalizeMap g bvToIxMapVal;
    let (_, g) ← g.revert #[mapFv]
    -- Apply Predicate.denote_of_eval_eq.
    let [g] ← g.apply <| (mkConst ``Predicate.denote_of_eval_eq)
      | throwError m!"Failed to apply `Predicate.denote_of_eval_eq` on goal '{indentD g}'"
    let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
      | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
    let [g] ← g.apply <| (mkConst ``Lean.ofReduceBool)
      | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
    return [g]

/--
Given a goal state of the form:
  ∀ (w : Nat)
  ∀ (b₁ b₂ ... bₙ : BitVec w),
  <proposition about bitvectors>.

decide the property by reduction to finite automata.

TODO(@bollu): Also decide properties about finite widths, by extending to the maximal width and clearing the high bits?
-/
elab "bv_reflect" : tactic => do
  liftMetaTactic fun g => do
    reflectUniversalWidthBVs g Config.default

/-- Allow elaboration of `bv_automata_circuit's config` arguments to tactics. -/
declare_config_elab elabBvAutomataCircuitConfig Config

syntax (name := bvAutomataCircuit) "bv_automata_circuit" (Lean.Parser.Tactic.config)? : tactic
@[tactic bvAutomataCircuit]
def evalBvAutomataCircuit : Tactic := fun
| `(tactic| bv_automata_circuit $[$cfg]?) => do
  let cfg ← elabBvAutomataCircuitConfig (mkOptionalNode cfg)

  liftMetaTactic fun g => do reflectUniversalWidthBVs g cfg

  match ← getUnsolvedGoals  with
  | [] => return ()
  -- | TODO: replace with ofReduceBool
  | [g] => do
    logInfo m!"goal being decided: {indentD g}"
    evalDecideCore `bv_automata_circuit (cfg := { native := true : Parser.Tactic.DecideConfig})
  | _gs => throwError "expected single goal after reflecting, found multiple goals. quitting"
| _ => throwUnsupportedSyntax

/-- Can solve explicitly quantified expressions with intros. bv_automata3. -/
theorem eq1 : ∀ (w : Nat) (a : BitVec w), a = a := by
  intros
  bv_automata_circuit
#print eq1

/-- Can solve implicitly quantified expressions by directly invoking bv_automata3. -/
theorem eq2 (w : Nat) (a : BitVec w) : a = a := by
  bv_automata_circuit
#print eq1


open NNF in

example (w : Nat) (a b : BitVec w) : a + b = b + a := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∨ (a = 0#w) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a = 0#w) ∨ (a + b = b + a) := by
  bv_automata_circuit

example (w : Nat) (a : BitVec w) : (a = 0#w) ∨ (a ≠ 0#w) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a + b = b + a) ∧ (a + 0#w = a) := by
  bv_automata_circuit

example (w : Nat) (a b : BitVec w) : (a ≠ b) → (b ≠ a) := by
  bv_automata_circuit

/-- either a < b or b ≤ a -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b ≤ a) := by
  bv_automata_circuit

/-- Tricohotomy of < -/
example (w : Nat) (a b : BitVec w) : (a < b) ∨ (b < a) ∨ (a = b) := by
  bv_automata_circuit

/-- < implies not equals -/
example (w : Nat) (a b : BitVec w) : (a < b) → (a ≠ b) := by
  bv_automata_circuit

/-- <= and >= implies equals -/
example (w : Nat) (a b : BitVec w) : ((a ≤ b) ∧ (b ≤ a)) → (a = b) := by
  bv_automata_circuit

example (a b : BitVec 1) : (a - b).slt 0 → a.slt b := by
  fail_if_success bv_decide
  -- The prover found a counterexample, consider the following assignment:
  -- a = 0x0#1
  -- b = 0x1#1
  sorry

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (1#w = 0#w) ∨ ((a - b).slt 0 → a.slt b) := by
  bv_automata_circuit


/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.sle a) := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- Tricohotomy of slt. Currently fails! -/
example (w : Nat) (a b : BitVec w) : (a.slt b) ∨ (b.slt a) ∨ (a = b) := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- a <=s b and b <=s a implies a = b-/
example (w : Nat) (a b : BitVec w) : ((a.sle b) ∧ (b.sle a)) → a = b := by
  bv_automata_circuit
  -- TODO: I don't understand this metaprogramming error, I must be building the term weirdly...

/-- In bitwidth 0, all values are equal.
In bitwidth 1, 1 + 1 = 0.
In bitwidth 2, 1 + 1 = 2 ≠ 0#2
For all bitwidths ≥ 2, we know that a ≠ a + 1
-/
example (w : Nat) (a : BitVec w) : (a ≠ a + 1#w) ∨ (1#w + 1#w = 0#w) ∨ (1#w = 0#w):= by
  bv_automata_circuit

/-- If we have that 'a &&& a = 0`, then we know that `a = 0` -/
example (w : Nat) (a : BitVec w) : (a &&& a = 0#w) → a = 0#w := by
  bv_automata_circuit

/-
Is this true at bitwidth 1? Not it is not!
So we need an extra hypothesis that rules out bitwifth 1.
We do this by saying that either the given condition, or 1+1 = 0.
I'm actually not sure why I need to rule out bitwidth 0? Mysterious!
-/
example (w : Nat) (a : BitVec w) : (1#w = 0#w) ∨ (1#w + 1#w = 0#w) ∨ ((a = - a) → a = 0#w) := by
  bv_automata_circuit


/-
We can say that we are at bitwidth 1 by saying that 1 + 1 = 0.
When we have this, we then explicitly enumerate the different values that a can have.
Note that this is pretty expensive.
-/
example (w : Nat) (a : BitVec w) : (1#w + 1#w = 0#w) → (a = 0#w ∨ a = 1#w) := by
  bv_automata_circuit



example (w : Nat) (a b : BitVec w) : (a + b = 0#w) → a = - b := by
  bv_automata_circuit


/-- Can use implications -/
theorem eq_circuit (w : Nat) (a b : BitVec w) : (a &&& b = 0#w) → ((a + b) = (a ||| b)) := by
  bv_nnf
  bv_automata_circuit

#print eq_circuit


open NNF in
/-- Can exploit hyps -/
theorem eq4 (w : Nat) (a b : BitVec w) (h : a &&& b = 0#w) : a + b = a ||| b := by
  bv_automata_circuit

#print eq_circuit

/--
warning: Width '10' is not a free variable (i.e. width is not universally quantified).
The tactic will perform width-generic reasoning.
To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = 10), ...
---
info: goal after NNF: ⏎
  a b : BitVec 10
  ⊢ a = b
---
info: goal after preprocessing: ⏎
  a b : BitVec 10
  ⊢ a = b
---
info: goal after reflection: ⏎
  a b : BitVec 10
  ⊢ (Predicate.eq (Term.var 0) (Term.var 1)).denote 10 (Map.append 10 b (Map.append 10 a Map.empty))
---
info: FSM: ⋆Circuit size '3'  ⋆State space size '0'
---
error: unsolved goals
case heval.a.h
a b : BitVec 10
⊢ reduceBool
      (Decidable.decide
        (∀ (w : ℕ) (vars : List BitStream), (Predicate.eq (Term.var 0) (Term.var 1)).eval vars w = false)) =
    true
-/
#guard_msgs in example : ∀ (a b : BitVec 10), a = b := by
  intros a b
  bv_reflect


section BvAutomataTests

/-!
# Test Cases
-/

/--
warning: Tactic has not understood the following expressions, and will treat them as symbolic:

  - f x
  - f y
-/
#guard_msgs (warning, drop error, drop info) in
theorem test_symbolic_abstraction (f : BitVec w → BitVec w) (x y : BitVec w) : f x ≠ f y :=
  by bv_automata_circuit

/-- Check that we correctly handle `OfNat.ofNat 1`. -/
theorem not_neg_eq_sub_one (x : BitVec 53):
    ~~~ (- x) = x - 1 := by
  all_goals bv_automata_circuit

/-- Check that we correctly handle multiplication by two. -/
theorem sub_eq_mul_and_not_sub_xor (x y : BitVec w):
    x - y = 2 * (x &&& ~~~ y) - (x ^^^ y) := by
  -- simp [Simplifications.BitVec.OfNat_ofNat_mul_eq_ofNat_mul]
  -- simp only [BitVec.ofNat_eq_ofNat, Simplifications.BitVec.two_mul_eq_add_add]
  all_goals bv_automata_circuit


/- See that such problems have large circuit sizes, but small state spaces -/
def alive_1 {w : ℕ} (x x_1 x_2 : BitVec w) : (x_2 &&& x_1 ^^^ x_1) + 1#w + x = x - (x_2 ||| ~~~x_1) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 81 })


def false_statement {w : ℕ} (x y : BitVec w) : x = y := by
  fail_if_success bv_automata_circuit
  sorry

def test_OfNat_ofNat (x : BitVec 1) : 1#1 + x = x + 1#1 := by
  bv_automata_circuit -- can't decide things for fixed bitwidth.

def test0 {w : Nat} (x y : BitVec w) : x + 0#w = x := by
  bv_automata_circuit


def test_simple2 {w : Nat} (x y : BitVec w) : x = x := by
  bv_automata_circuit

def test1 {w : Nat} (x y : BitVec w) : (x ||| y) - (x ^^^ y) = x &&& y := by
  bv_automata_circuit


def test4 (x y : BitVec w) : (x + -y) = (x - y) := by
  bv_automata_circuit

def test5 (x y z : BitVec w) : (x + y + z) = (z + y + x) := by
  bv_automata_circuit


def test6 (x y z : BitVec w) : (x + (y + z)) = (x + y + z) := by
  bv_automata_circuit

def test11 (x y : BitVec w) : (x + y) = ((x |||  y) +  (x &&&  y)) := by
  bv_automata_circuit


def test15 (x y : BitVec w) : (x - y) = (( x &&& (~~~ y)) - ((~~~ x) &&&  y)) := by
  bv_automata_circuit

def test17 (x y : BitVec w) : (x ^^^ y) = ((x ||| y) - (x &&& y)) := by
  bv_automata_circuit


def test18 (x y : BitVec w) : (x &&&  (~~~ y)) = ((x ||| y) - y) := by
  bv_automata_circuit


def test19 (x y : BitVec w) : (x &&&  (~~~ y)) = (x -  (x &&& y)) := by
  bv_automata_circuit


def test21 (x y : BitVec w) : (~~~(x - y)) = (~~~x + y) := by
  bv_automata_circuit

def test2_circuit (x y : BitVec w) : (~~~(x ^^^ y)) = ((x &&& y) + ~~~(x ||| y)) := by
  bv_automata_circuit

def test24 (x y : BitVec w) : (x ||| y) = (( x &&& (~~~y)) + y) := by
  bv_automata_circuit

def test25 (x y : BitVec w) : (x &&& y) = (((~~~x) ||| y) - ~~~x) := by
  bv_automata_circuit

def test26 {w : Nat} (x y : BitVec w) : 1#w + x + 0#w = 1#w + x := by
  bv_automata_circuit

/-- NOTE: we now support 'ofNat' literals -/
def test27 (x y : BitVec w) : 2#w + x  = 1#w  + x + 1#w := by
  bv_automata_circuit

def test28 {w : Nat} (x y : BitVec w) : x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata_circuit

example : ∀ (w : Nat) , (BitVec.ofNat w 1) &&& (BitVec.ofNat w 3) = BitVec.ofNat w 1 := by
  intros
  bv_automata_circuit

example : ∀ (w : Nat) (x : BitVec w), (BitVec.ofInt w (-1)) &&& x = x := by
  intros
  bv_automata_circuit

example : ∀ (w : Nat) (x : BitVec w), x <<< (0 : Nat) = x := by intros; bv_automata_circuit
example : ∀ (w : Nat) (x : BitVec w), x <<< (1 : Nat) = x + x := by intros; bv_automata_circuit
example : ∀ (w : Nat) (x : BitVec w), x <<< (2 : Nat) = x + x + x + x := by
  intros; bv_automata_circuit


/-- Can solve width-constraints problems, but this takes a while. -/
def test29 (x y : BitVec w) : w = 32 → x &&& x &&& x &&& x &&& x &&& x = x := by
  bv_automata_circuit (config := { stateSpaceSizeThreshold := 33 })

/-- Can solve width-constraints problems -/
def test30  : (w = 2) → 8#w = 0#w := by
  bv_automata_circuit

/-- Can solve width-constraints problems -/
def test31 (w : Nat) (x : BitVec w) : (w = 64) → x &&& x = x := by
  bv_automata_circuit (config := { stateSpaceSizeThreshold := 65 })

theorem neg_eq_not_add_one (x : BitVec w) :
    -x = ~~~ x + 1#w := by
  bv_automata_circuit

theorem add_eq_xor_add_mul_and (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 100 } )

theorem add_eq_xor_add_mul_and' (x y : BitVec w) :
    x + y = (x ^^^ y) + (x &&& y) + (x &&& y) := by
  bv_automata_circuit (config := { circuitSizeThreshold := 100 } )

theorem add_eq_xor_add_mul_and_nt (x y : BitVec w) :
    x + y = (x ^^^ y) + 2 * (x &&& y) := by
  bv_automata_circuit

/-- Check that we correctly process an even numeral multiplication. -/
theorem mul_four (x : BitVec w) :
  4 * x = x + x + x + x := by
  fail_if_success bv_automata_circuit
  sorry

/-- Check that we correctly process an odd numeral multiplication. -/
theorem mul_five (x : BitVec w) :
  5 * x = x + x + x + x + 5 := by
  fail_if_success bv_automata_circuit
  sorry

open BitVec in
/-- Check that we support sign extension. -/
theorem sext
    (b : BitVec 8)
    (c : ¬(11#9 - signExtend 9 (b &&& 7#8)).msb = (11#9 - signExtend 9 (b &&& 7#8)).getMsbD 1) :
    False := by
  fail_if_success bv_automata_circuit
  sorry

/-- Check that we support zero extension. -/
theorem zext (b : BitVec 8) : (b.zeroExtend 10 |>.zeroExtend 8) = b := by
  fail_if_success bv_automata_circuit
  sorry

/--
warning: Width '1' is not a free variable (i.e. width is not universally quantified).
The tactic will perform width-generic reasoning.
To perform width-specific reasoning, rewrite goal with a width constraint, e.g. ∀ (w : Nat) (hw : w = 1), ...
---
info: goal after NNF: ⏎
  x : BitVec 1
  ⊢ x + x + x + x = 0#1
---
info: goal after preprocessing: ⏎
  x : BitVec 1
  ⊢ x + x + x + x = 0#1
---
info: goal after reflection: ⏎
  x : BitVec 1
  ⊢ (Predicate.eq ((((Term.var 0).add (Term.var 0)).add (Term.var 0)).add (Term.var 0)) Term.zero).denote 1
      (Map.append 1 x Map.empty)
---
info: FSM: ⋆Circuit size '70'  ⋆State space size '3'
---
info: goal being decided: ⏎
  case heval.a.h
  x : BitVec 1
  ⊢ reduceBool
        (Decidable.decide
          (∀ (w : ℕ) (vars : List BitStream),
            (Predicate.eq ((((Term.var 0).add (Term.var 0)).add (Term.var 0)).add (Term.var 0)) Term.zero).eval vars w =
              false)) =
      true
---
error: tactic 'bv_automata_circuit' evaluated that the proposition
  reduceBool
      (Decidable.decide
        (∀ (w : ℕ) (vars : List BitStream),
          (Predicate.eq ((((Term.var 0).add (Term.var 0)).add (Term.var 0)).add (Term.var 0)) Term.zero).eval vars w =
            false)) =
    true
is false
-/
#guard_msgs in def width_generic_exploit_fail (x : BitVec 1) : x + x + x + x = 0#1 := by
  bv_automata_circuit
  sorry

/-- Can solve width-constraints problems, when written with a width constraint. -/
def width_generic_exploit_success (x : BitVec w) (hw : w = 1) : x + x + x + x = 0#w := by
  bv_automata_circuit

set_option trace.profiler true  in
/-- warning: declaration uses 'sorry' -/
theorem slow₁ (x : BitVec 32) :
    63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 := by
  fail_if_success bv_automata_circuit (config := { circuitSizeThreshold := 30, stateSpaceSizeThreshold := 24 } )
  sorry

end BvAutomataTests

end Reflect
