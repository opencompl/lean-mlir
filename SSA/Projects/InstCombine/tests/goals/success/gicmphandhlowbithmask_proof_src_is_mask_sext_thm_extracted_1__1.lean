
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_mask_sext_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 → x_1 ≥ ↑8 ∨ True ∧ (31#8 >>> x_1).msb = true → False :=
sorry