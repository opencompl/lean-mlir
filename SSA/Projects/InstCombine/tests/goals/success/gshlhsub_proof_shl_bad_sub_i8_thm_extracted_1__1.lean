
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_bad_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#8 - x ≥ ↑8 → True ∧ 1#8 <<< (4#8 - x) >>> (4#8 - x) ≠ 1#8 ∨ 4#8 - x ≥ ↑8 → False :=
sorry