
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_p2_m1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    ofBool (2#8 <<< x_1 + -1#8 &&& (x ^^^ 123#8) <ᵤ x ^^^ 123#8) = ofBool (2#8 <<< x_1 + -1#8 <ᵤ x ^^^ 123#8) :=
sorry