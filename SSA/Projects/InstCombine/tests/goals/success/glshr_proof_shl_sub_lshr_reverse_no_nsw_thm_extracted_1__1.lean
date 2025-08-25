
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

theorem shl_sub_lshr_reverse_no_nsw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨
        x ≥ ↑32 ∨
          True ∧ x_2.usubOverflow (x_1 <<< x) = true ∨
            True ∧ (x_2 - x_1 <<< x) >>> x <<< x ≠ x_2 - x_1 <<< x ∨ x ≥ ↑32) →
    True ∧ x_2 >>> x <<< x ≠ x_2 ∨ x ≥ ↑32 ∨ True ∧ (x_2 >>> x).usubOverflow x_1 = true → False :=
sorry