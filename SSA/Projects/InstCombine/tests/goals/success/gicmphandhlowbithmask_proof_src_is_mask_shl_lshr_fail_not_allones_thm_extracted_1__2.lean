
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_shl_lshr_fail_not_allones_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    ¬x ≥ ↑8 →
      ofBool (0#8 != (x_1 ^^^ 123#8) &&& (BitVec.ofInt 8 (-2) <<< x >>> x ^^^ -1#8)) =
        ofBool (x_1 ^^^ BitVec.ofInt 8 (-124) ||| (-1#8) >>> x &&& BitVec.ofInt 8 (-2) != -1#8) :=
sorry