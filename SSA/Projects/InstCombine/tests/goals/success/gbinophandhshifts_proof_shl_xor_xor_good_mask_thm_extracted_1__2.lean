
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_xor_xor_good_mask_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) → ¬1#8 ≥ ↑8 → x_1 <<< 1#8 ^^^ (x <<< 1#8 ^^^ 88#8) = (x ^^^ x_1) <<< 1#8 ^^^ 88#8 :=
sorry