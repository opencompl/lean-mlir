
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

theorem mul9_low_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ¬(4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9 ∨ 4#9 ≥ ↑9) →
    4#9 ≥ ↑9 ∨
        True ∧ (x_1 >>> 4#9).umulOverflow (x &&& 15#9) = true ∨
          4#9 ≥ ↑9 ∨
            True ∧ (x_1 &&& 15#9).umulOverflow (x >>> 4#9) = true ∨
              4#9 ≥ ↑9 ∨
                True ∧ (x_1 &&& 15#9).smulOverflow (x &&& 15#9) = true ∨
                  True ∧ (x_1 &&& 15#9).umulOverflow (x &&& 15#9) = true →
      False :=
sorry