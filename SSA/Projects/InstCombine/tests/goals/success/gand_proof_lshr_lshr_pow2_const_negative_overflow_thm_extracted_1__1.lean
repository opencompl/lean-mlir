
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_lshr_pow2_const_negative_overflow_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 15#16 ≥ ↑16) → BitVec.ofInt 16 (-32768) >>> x >>> 15#16 &&& 4#16 = 0#16 :=
sorry