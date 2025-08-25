
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

theorem PR30273_three_bools_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 →
    x_1 = 1#1 →
      ¬(True ∧ (zeroExtend 32 x).saddOverflow 1#32 = true) →
        ¬x = 1#1 →
          ¬(True ∧ (zeroExtend 32 x + 1#32).saddOverflow 1#32 = true) →
            ¬(True ∧ (1#32).saddOverflow (zeroExtend 32 x_2) = true ∨
                  True ∧ (1#32).uaddOverflow (zeroExtend 32 x_2) = true) →
              zeroExtend 32 x + 1#32 + 1#32 = 1#32 + zeroExtend 32 x_2 :=
sorry