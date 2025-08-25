
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

theorem lshr_32_add_known_32_leading_zeroes_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬32#64 ≥ ↑64 →
    True ∧ (x_1 &&& 4294967295#64).saddOverflow (x &&& 4294967295#64) = true ∨
        True ∧ (x_1 &&& 4294967295#64).uaddOverflow (x &&& 4294967295#64) = true ∨ 32#64 ≥ ↑64 →
      False :=
sorry