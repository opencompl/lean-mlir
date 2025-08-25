
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_shl_lshr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬x ≥ ↑8 →
      ofBool (0#8 != (x_1 ^^^ 123#8) &&& ((-1#8) <<< x >>> x ^^^ -1#8)) = ofBool ((-1#8) >>> x <ᵤ x_1 ^^^ 122#8) :=
sorry