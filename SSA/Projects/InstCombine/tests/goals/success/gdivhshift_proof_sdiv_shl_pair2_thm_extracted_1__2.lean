
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

theorem sdiv_shl_pair2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ (x_2 <<< x_1).sshiftRight' x_1 ≠ x_2 ∨
        True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
          x_1 ≥ ↑32 ∨
            True ∧ (x_2 <<< x).sshiftRight' x ≠ x_2 ∨
              x ≥ ↑32 ∨ (x_2 <<< x == 0 || 32 != 1 && x_2 <<< x_1 == intMin 32 && x_2 <<< x == -1) = true) →
    ¬(True ∧ (1#32 <<< x_1).sshiftRight' x_1 ≠ 1#32 ∨ True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨ x_1 ≥ ↑32 ∨ x ≥ ↑32) →
      (x_2 <<< x_1).sdiv (x_2 <<< x) = 1#32 <<< x_1 >>> x :=
sorry