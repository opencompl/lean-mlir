
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem is_ascii_alphabetic_inverted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-91)) = true) →
    ofBool (x + BitVec.ofInt 32 (-91) <ᵤ BitVec.ofInt 32 (-26)) = 1#1 →
      ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-123)) = true) →
        ofBool (x + BitVec.ofInt 32 (-123) <ᵤ BitVec.ofInt 32 (-26)) =
          ofBool ((x &&& BitVec.ofInt 32 (-33)) + BitVec.ofInt 32 (-91) <ᵤ BitVec.ofInt 32 (-26)) :=
sorry