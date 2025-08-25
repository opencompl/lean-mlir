
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_lshr_bitwidth_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → (x_1 >>> 7#8 ^^^ -1#8) &&& x = x &&& (x_1 >>> 7#8 ^^^ -1#8) :=
sorry