
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

theorem select_or_disjoint_or_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(4#32 ≥ ↑32 ∨ True ∧ (4#32 &&& x <<< 4#32 != 0) = true) →
      4#32 ≥ ↑32 ∨
          True ∧ (4#32 &&& x <<< 4#32 != 0) = true ∨
            True ∧ (4#32 ||| x <<< 4#32).saddOverflow 4#32 = true ∨
              True ∧ (4#32 ||| x <<< 4#32).uaddOverflow 4#32 = true →
        False :=
sorry