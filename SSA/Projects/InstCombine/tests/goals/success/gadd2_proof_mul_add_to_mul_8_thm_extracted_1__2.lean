
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

theorem mul_add_to_mul_8_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 16383#16 = true ∨
        True ∧ x.smulOverflow 16384#16 = true ∨ True ∧ (x * 16383#16).saddOverflow (x * 16384#16) = true) →
    ¬(True ∧ x.smulOverflow 32767#16 = true) → x * 16383#16 + x * 16384#16 = x * 32767#16 :=
sorry