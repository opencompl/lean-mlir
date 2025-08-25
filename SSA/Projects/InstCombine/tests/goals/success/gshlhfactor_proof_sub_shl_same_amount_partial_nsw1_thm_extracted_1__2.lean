
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)

theorem sub_shl_same_amount_partial_nsw1_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 6),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨ x_1 ≥ ↑6 ∨ True ∧ (x <<< x_1).sshiftRight' x_1 ≠ x ∨ x_1 ≥ ↑6) →
    ¬x_1 ≥ ↑6 → x_2 <<< x_1 - x <<< x_1 = (x_2 - x) <<< x_1 :=
sorry