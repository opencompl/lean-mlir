
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_lshr_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 : BitVec 8),
  ¬x_2 = 1#1 →
    ¬x ≥ ↑8 → ofBool (x_3 ^^^ 123#8 != 15#8 >>> x &&& (x_3 ^^^ 123#8)) = ofBool (15#8 >>> x <ᵤ x_3 ^^^ 123#8) :=
sorry