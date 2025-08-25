
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

theorem add_nsw_const_const_sub_nsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 1#8 = true ∨ True ∧ (BitVec.ofInt 8 (-127)).ssubOverflow (x + 1#8) = true) →
    ¬(True ∧ (BitVec.ofInt 8 (-128)).ssubOverflow x = true) →
      BitVec.ofInt 8 (-127) - (x + 1#8) = BitVec.ofInt 8 (-128) - x :=
sorry