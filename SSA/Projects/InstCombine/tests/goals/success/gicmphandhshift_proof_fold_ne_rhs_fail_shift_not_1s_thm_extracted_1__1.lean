
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_ne_rhs_fail_shift_not_1s_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x ≥ ↑8 →
    ofBool ((x_1 ^^^ 123#8) &&& BitVec.ofInt 8 (-2) <<< x != 0#8) =
      ofBool ((x_1 ^^^ 122#8) &&& BitVec.ofInt 8 (-2) <<< x != 0#8) :=
sorry