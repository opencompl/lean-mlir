
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem prove_exact_with_high_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(4#8 == 0 || 8 != 1 && x &&& BitVec.ofInt 8 (-8) == intMin 8 && 4#8 == -1) = true → 2#8 ≥ ↑8 → False :=
sorry