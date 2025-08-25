
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_pow2_const_overflow_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → 8192#16 >>> x <<< 6#16 &&& 32#16 = 0#16 :=
sorry