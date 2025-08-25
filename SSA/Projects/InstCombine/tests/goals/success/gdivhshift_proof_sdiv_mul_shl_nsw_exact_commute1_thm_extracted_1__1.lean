
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

theorem sdiv_mul_shl_nsw_exact_commute1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.smulOverflow x_1 = true ∨
        True ∧ (x_1 <<< x).sshiftRight' x ≠ x_1 ∨
          x ≥ ↑5 ∨
            True ∧ (x_2 * x_1).smod (x_1 <<< x) ≠ 0 ∨
              (x_1 <<< x == 0 || 5 != 1 && x_2 * x_1 == intMin 5 && x_1 <<< x == -1) = true) →
    True ∧ 1#5 <<< x >>> x ≠ 1#5 ∨
        x ≥ ↑5 ∨
          True ∧ x_2.smod (1#5 <<< x) ≠ 0 ∨ (1#5 <<< x == 0 || 5 != 1 && x_2 == intMin 5 && 1#5 <<< x == -1) = true →
      False :=
sorry