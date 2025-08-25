
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_mask1_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#8 ≥ ↑8 → ¬(4#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) → 0#8 - (x >>> 3#8 &&& 1#8) = (x <<< 4#8).sshiftRight' 7#8 :=
sorry