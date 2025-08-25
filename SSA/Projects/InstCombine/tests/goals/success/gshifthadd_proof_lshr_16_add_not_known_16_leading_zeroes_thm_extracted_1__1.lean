
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

theorem lshr_16_add_not_known_16_leading_zeroes_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬16#32 ≥ ↑32 →
    True ∧ (x_1 &&& 131071#32).saddOverflow (x &&& 65535#32) = true ∨
        True ∧ (x_1 &&& 131071#32).uaddOverflow (x &&& 65535#32) = true ∨ 16#32 ≥ ↑32 →
      False :=
sorry