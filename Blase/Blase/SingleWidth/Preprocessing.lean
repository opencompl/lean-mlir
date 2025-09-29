import Blase.ForLean
import Blase.SingleWidth.Attr
import Mathlib.Data.Nat.Bits
import Mathlib.Algebra.Group.Nat.Defs

set_option grind.warning false

namespace Simplifications

/-!
Canonicalize `OfNat.ofNat`, `BitVec.ofNat` and `Nat` multiplication to become
`BitVec.ofNat` multiplication with constant on the left.
-/

attribute [bv_automata_preprocess] BitVec.ofNat_eq_ofNat

/-- Canonicalize multiplications by numerals. -/
@[bv_automata_preprocess] theorem BitVec.mul_nat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  x * n = BitVec.ofNat w n * x  := by rw [BitVec.mul_comm]; simp

/-- Canonicalize multiplications by numerals to have constants on the left,
with BitVec.ofNat -/
@[bv_automata_preprocess] theorem BitVec.nat_mul_eq_ofNat_mul (x : BitVec w) (n : Nat) :
  n * x = BitVec.ofNat w n * x := by rfl

/-- Reassociate multiplication to move constants to left. -/
@[bv_automata_preprocess] theorem BitVec.mul_ofNat_eq_ofNat_mul (x : BitVec w) (n : Nat) :
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

@[bv_automata_preprocess] theorem BitVec.two_mul_eq_add_add (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq;
  simp only [BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod, BitVec.toNat_add]
  congr
  omega

@[bv_automata_preprocess] theorem BitVec.two_mul (x : BitVec w) : 2#w * x = x + x := by
  apply BitVec.eq_of_toNat_eq
  simp only [BitVec.toNat_mul, BitVec.toNat_ofNat, Nat.mod_mul_mod, BitVec.toNat_add]
  congr
  omega

@[bv_automata_preprocess] theorem BitVec.one_mul (x : BitVec w) : 1#w * x = x := by simp

@[bv_automata_preprocess] theorem BitVec.zero_mul (x : BitVec w) : 0#w * x = 0#w := by simp

-- @[bv_automata_preprocess] theorem BitVec.neg_one_mul (x : BitVec w) : -1#w * x = -x := by simp

@[bv_automata_preprocess] theorem BitVec.neg_mul (x y : BitVec w) : (- x) * y = -(x * y) := by simp


open Lean Meta Elab in

/--
Given an equality proof with `lhs = rhs`, return the `rhs`,
and bail out if we are unable to determine it precisely (i.e. no loose metavars).
-/
def getEqRhs (eq : Expr) : MetaM Expr := do
  check eq
  let eq ← whnf <| ← inferType eq
  let some (_ty, _lhs, rhs) := eq.eq? | throwError m!"unable to infer RHS for equality {eq}"
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
simproc↓ [bv_automata_preprocess] shiftLeft_break_down ((BitVec.ofNat _ _) * (_ : BitVec _)) := fun x => do
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
      #[_w, x, mkNatLit <| kVal/2, mkNatLit kVal,  (← mkEqRefl k)]
    return .visit { proof? := eqProof, expr := ← getEqRhs eqProof }
  | _ => return .continue

open Lean Elab Meta
def runPreprocessing (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_automata_preprocess)
    | throwError m!"'bv_automata_preprocess' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_automata_preprocess)
    | throwError m!" 'bv_automata_preprocess' simp attribute not found!"
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

/-- convert goal to negation normal form, by running appropriate lemmas from `bv_automata_nnf`, and reverting all hypothese. -/
def runNNFSimpSet (g : MVarId) : MetaM (Option MVarId) := do
  let some ext ← (getSimpExtension? `bv_automata_nnf)
    | throwError m!"[bv_nnf] Error: 'bv_automata_nnf' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? `bv_automata_nnf)
    | throwError m!"[bv_nnf] Error: 'bv_automata_nnf' simp attribute not found!"
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

attribute [bv_automata_nnf] BitVec.not_lt
attribute [bv_automata_nnf] BitVec.not_le

@[bv_automata_nnf]
theorem implies_eq_not_a_or_b (a b : Prop) : (a → b) = (¬ a ∨ b) := by
  by_cases a
  case pos h => simp [h]
  case neg h => simp [h]

@[bv_automata_nnf]
theorem iff_eq_double_impl (a b : Prop) : (a ↔ b) = ((a → b) ∧ (b → a)) := by grind

@[bv_automata_nnf]
theorem sle_iff_slt_eq_false {a b : BitVec w} : a.slt b = false ↔ b.sle a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega

@[bv_automata_nnf]
theorem ule_iff_ult_eq_false {a b : BitVec w} : a.ult b = false ↔ b.ule a := by
  constructor <;>
  intros h <;>
  simp [BitVec.ule, BitVec.ult] at h ⊢ <;>
  omega

@[bv_automata_nnf]
theorem slt_iff_sle_eq_false {a b : BitVec w} : a.sle b = false ↔ b.slt a := by
  constructor <;>
  intros h <;>
  simp [BitVec.sle, BitVec.slt] at h ⊢ <;>
  omega

@[bv_automata_nnf]
theorem ult_iff_ule_eq_false {a b : BitVec w} : a.ule b = false ↔ b.ult a := by
  constructor <;>
  intros h <;>
  simp [BitVec.ule, BitVec.ult] at h ⊢ <;>
  omega

/-!
Normalization theorems for the `grind` tactic.

We are also going to use simproc's in the future.
-/

attribute [bv_automata_nnf] ofBool_1_iff_true ofBool_0_iff_false

-- Not
attribute [bv_automata_nnf] Classical.not_not

@[bv_automata_nnf] theorem not_eq_eq {α : Sort u} (a b : α) : (¬ (a = b)) = (a ≠ b) := by simp

-- Iff
@[bv_automata_nnf] theorem iff_eq (p q : Prop) : (p ↔ q) = (p = q) := by
  by_cases p <;> by_cases q <;> simp [*]

-- Eq
attribute [bv_automata_nnf] eq_self heq_eq_eq

-- Prop equality
@[bv_automata_nnf] theorem eq_true_eq (p : Prop) : (p = True) = p := by simp
@[bv_automata_nnf] theorem eq_false_eq (p : Prop) : (p = False) = ¬p := by simp
@[bv_automata_nnf] theorem not_eq_prop (p q : Prop) : (¬(p = q)) = (p = ¬q) := by
  by_cases p <;> by_cases q <;> simp [*]

-- True
attribute [bv_automata_nnf] not_true

-- False
attribute [bv_automata_nnf] not_false_eq_true

-- Remark: we disabled the following normalization rule because we want this information when implementing splitting heuristics
-- Implication as a clause
theorem imp_eq (p q : Prop) : (p → q) = (¬ p ∨ q) := by
  by_cases p <;> by_cases q <;> simp [*]

@[bv_automata_nnf] theorem true_imp_eq (p : Prop) : (True → p) = p := by simp
@[bv_automata_nnf] theorem false_imp_eq (p : Prop) : (False → p) = True := by simp
@[bv_automata_nnf] theorem imp_true_eq (p : Prop) : (p → True) = True := by simp
@[bv_automata_nnf] theorem imp_false_eq (p : Prop) : (p → False) = ¬p := by simp
@[bv_automata_nnf] theorem imp_self_eq (p : Prop) : (p → p) = True := by simp

-- And
@[bv_automata_nnf↓] theorem not_and (p q : Prop) : (¬(p ∧ q)) = (¬p ∨ ¬q) := by
  by_cases p <;> by_cases q <;> simp [*]
attribute [bv_automata_nnf] and_true true_and and_false false_and and_assoc

-- TODO categorize
attribute [bv_automata_nnf]
  BitVec.ofBool_or_ofBool ofBool_1_iff_true bne_iff_ne

-- Or
attribute [bv_automata_nnf↓] not_or
attribute [bv_automata_nnf] or_true true_or or_false false_or or_assoc

-- ite
attribute [bv_automata_nnf] ite_true ite_false
@[bv_automata_nnf↓] theorem not_ite {_ : Decidable p} (q r : Prop) : (¬ite p q r) = ite p (¬q) (¬r) := by
  by_cases p <;> simp [*]

@[bv_automata_nnf] theorem ite_true_false {_ : Decidable p} : (ite p True False) = p := by
  by_cases p <;> simp

@[bv_automata_nnf] theorem ite_false_true {_ : Decidable p} : (ite p False True) = ¬p := by
  by_cases p <;> simp

-- Forall
@[bv_automata_nnf↓] theorem not_forall (p : α → Prop) : (¬∀ x, p x) = ∃ x, ¬p x := by simp
attribute [bv_automata_nnf] forall_and

-- Exists
@[bv_automata_nnf↓] theorem not_exists (p : α → Prop) : (¬∃ x, p x) = ∀ x, ¬p x := by simp
attribute [bv_automata_nnf] exists_const exists_or exists_prop exists_and_left exists_and_right

-- Bool cond
@[bv_automata_nnf] theorem cond_eq_ite (c : Bool) (a b : α) : cond c a b = ite c a b := by
  cases c <;> simp [*]

-- Bool or
attribute [bv_automata_nnf]
  Bool.or_false Bool.or_true Bool.false_or Bool.true_or Bool.or_eq_true Bool.or_assoc

@[bv_automata_nnf] theorem Bool.or_eq_false : ((a || b) = false) = (a = false ∧ b = false) := by grind

-- Bool and
attribute [bv_automata_nnf]
  Bool.and_false Bool.and_true Bool.false_and Bool.true_and Bool.and_eq_true Bool.and_assoc

@[bv_automata_nnf] theorem Bool.and_eq_false : ((a && b) = false) = (a = false ∨ b = false) := by grind

-- Bool not
attribute [bv_automata_nnf]
  Bool.not_not

-- beq
attribute [bv_automata_nnf] beq_iff_eq

-- bne
attribute [bv_automata_nnf] bne_iff_ne

-- Bool not eq true/false
attribute [bv_automata_nnf] Bool.not_eq_false Bool.not_eq_true

-- decide
attribute [bv_automata_nnf] decide_eq_true_eq decide_not not_decide_eq_true

-- Nat LE
attribute [bv_automata_nnf] Nat.le_zero_eq

-- Nat/Int LT
@[bv_automata_nnf] theorem Nat.lt_eq (a b : Nat) : (a < b) = (a + 1 ≤ b) := by
  simp [Nat.lt, LT.lt]

@[bv_automata_nnf] theorem Int.lt_eq (a b : Int) : (a < b) = (a + 1 ≤ b) := by
  simp [Int.lt, LT.lt]

-- GT GE
attribute [bv_automata_nnf] GT.gt GE.ge

-- Succ
attribute [bv_automata_nnf] Nat.succ_eq_add_one

@[bv_automata_nnf]
theorem BitVec.lt_ult {x y : BitVec w} : (x < y) = (x.ult y) := by
  simp [instLTBitVec, BitVec.ult]

@[bv_automata_nnf]
theorem BitVec.le_ule {x y : BitVec w} : (x ≤ y) = (x.ule y) := by
  simp [instLEBitVec, BitVec.ule]

-- Copy all the bool_to_prop lemmas

attribute [bv_automata_nnf] decide_eq_true_iff decide_eq_decide Bool.and_eq_decide Bool.or_eq_decide Bool.decide_beq_decide

theorem bool_eq_iff (b₁ b₂ : Bool) : (b₁ = b₂) = (b₁ ↔ b₂) := by grind

open Lean in
simproc [bv_automata_nnf] boolEqIff (@Eq Bool _ _) := fun e => do
  match_expr e with
  | Eq α e₁ e₂ =>
    unless α == .const ``Bool [] do
      return .continue
    match_expr e₁ with
    | true => pure .continue
    | false => pure .continue
    | _ =>
      match_expr e₂ with
      | true => pure .continue
      | false => pure .continue
      | _ =>
        let it e := (mkApp3 (.const ``Eq [levelOne]) (.const ``Bool []) e (.const ``true []))
        let e' := mkApp2 (.const ``Iff []) (it e₁) (it e₂)
        let pf := mkApp2 (.const ``bool_eq_iff []) e₁ e₂
        pure $ .done { expr := e', proof? := some pf }
  | _ => pure .continue


/--
trace: w : ℕ
⊢ (∀ (x x_1 : BitVec w), x_1.ule x = true) ∧
    ∀ (x x_1 : BitVec w), x.ule x_1 = true ∨ x_1.ult x = true ∨ x.ule x_1 = true ∨ x ≠ x_1
---
warning: declaration uses 'sorry'
-/
#guard_msgs in example : ∀ (a b : BitVec w),  ¬ (a < b ∨ a > b ∧ a ≤ b ∧ a > b ∧ (¬ (a ≠ b))) := by
 bv_nnf;
 trace_state; sorry

/--
trace: w : ℕ
⊢ ∀ (a b : BitVec w), a &&& b ≠ 0#w ∨ a = b
---
warning: declaration uses 'sorry'
-/
#guard_msgs in example : ∀ (a b : BitVec w), a &&& b = 0#w → a = b := by
 bv_nnf; trace_state; sorry

end NNF
