
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

theorem test_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 64),
  ¬x = 1#1 →
    ¬(4#64 ≥ ↑64 ∨
          3#64 ≥ ↑64 ∨
            True ∧ (x_1 >>> 4#64).saddOverflow (x_1 >>> 3#64) = true ∨
              True ∧ (x_1 >>> 4#64).uaddOverflow (x_1 >>> 3#64) = true) →
      ¬(8#64 = 0 ∨ 0#64 = 0) → x_1 / 8#64 + x_1 / 0#64 = x_1 >>> 4#64 + x_1 >>> 3#64 :=
sorry