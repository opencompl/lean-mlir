
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_xor_or_good_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(4#8 ≥ ↑8 ∨ 4#8 ≥ ↑8) → 4#8 ≥ ↑8 ∨ True ∧ ((x ||| x_1) >>> 4#8 &&& 48#8 != 0) = true → False :=
sorry