
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_lshr_shl_fail_mismatch_shifts_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    ofBool (((-1#8) >>> x_2 <<< x_1 ^^^ -1#8) &&& (x ^^^ 123#8) == x ^^^ 123#8) =
      ofBool ((x ^^^ 123#8) &&& (-1#8) >>> x_2 <<< x_1 == 0#8) :=
sorry