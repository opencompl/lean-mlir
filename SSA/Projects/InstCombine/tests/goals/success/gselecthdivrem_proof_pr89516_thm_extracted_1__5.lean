
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

theorem pr89516_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 <ₛ 0#8) = 1#1 →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && 1#8 == intMin 8 && 1#8 <<< x == -1) = true) →
      ¬(True ∧ ((1#8).srem (1#8 <<< x)).uaddOverflow 0#8 = true) →
        (1#8).srem (1#8 <<< x) = (1#8).srem (1#8 <<< x) + 0#8 :=
sorry