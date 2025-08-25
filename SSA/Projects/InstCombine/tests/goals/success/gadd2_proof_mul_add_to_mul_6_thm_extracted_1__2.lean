
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

theorem mul_add_to_mul_6_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.smulOverflow x = true ∨
        True ∧ x_1.smulOverflow x = true ∨
          True ∧ (x_1 * x).smulOverflow 5#32 = true ∨ True ∧ (x_1 * x).saddOverflow (x_1 * x * 5#32) = true) →
    ¬(True ∧ x_1.smulOverflow x = true ∨ True ∧ (x_1 * x).smulOverflow 6#32 = true) →
      x_1 * x + x_1 * x * 5#32 = x_1 * x * 6#32 :=
sorry