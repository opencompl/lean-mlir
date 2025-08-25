
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_pow2_const_case1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 2#16 ≥ ↑16) → ofBool (x == 7#16) = 1#1 → 256#16 >>> x <<< 2#16 &&& 8#16 = 8#16 :=
sorry