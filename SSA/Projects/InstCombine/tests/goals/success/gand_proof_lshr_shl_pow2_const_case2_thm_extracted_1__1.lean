
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_pow2_const_case2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 4#16 ≥ ↑16) → ofBool (x == 12#16) = 1#1 → 8192#16 >>> x <<< 4#16 &&& 32#16 = 32#16 :=
sorry