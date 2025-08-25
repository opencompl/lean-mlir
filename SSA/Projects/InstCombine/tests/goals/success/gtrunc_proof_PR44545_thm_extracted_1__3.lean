
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

theorem PR44545_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ x.saddOverflow 1#32 = true ∨ True ∧ x.uaddOverflow 1#32 = true) →
      ¬(True ∧ (truncate 16 (x + 1#32)).saddOverflow (-1#16) = true) → truncate 16 (x + 1#32) + -1#16 = truncate 16 x :=
sorry