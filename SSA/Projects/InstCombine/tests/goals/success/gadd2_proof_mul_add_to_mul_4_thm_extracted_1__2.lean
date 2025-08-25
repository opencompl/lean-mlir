
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

theorem mul_add_to_mul_4_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 2#16 = true ∨
        True ∧ x.smulOverflow 7#16 = true ∨ True ∧ (x * 2#16).saddOverflow (x * 7#16) = true) →
    ¬(True ∧ x.smulOverflow 9#16 = true) → x * 2#16 + x * 7#16 = x * 9#16 :=
sorry