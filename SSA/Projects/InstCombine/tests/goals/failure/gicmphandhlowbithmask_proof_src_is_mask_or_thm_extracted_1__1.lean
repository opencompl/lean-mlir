
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 →
    ofBool (x_1 ^^^ 123#8 == (-1#8) >>> x &&& 7#8 &&& (x_1 ^^^ 123#8)) =
      ofBool (x_1 ^^^ 123#8 ≤ᵤ (-1#8) >>> x &&& 7#8) :=
sorry