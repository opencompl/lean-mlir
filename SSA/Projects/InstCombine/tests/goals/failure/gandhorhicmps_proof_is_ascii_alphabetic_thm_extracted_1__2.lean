
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem is_ascii_alphabetic_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-65)) = true) →
    ¬ofBool (x + BitVec.ofInt 32 (-65) <ᵤ 26#32) = 1#1 →
      ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-97)) = true) →
        ofBool (x + BitVec.ofInt 32 (-97) <ᵤ 26#32) =
          ofBool ((x &&& BitVec.ofInt 32 (-33)) + BitVec.ofInt 32 (-65) <ᵤ 26#32) :=
sorry