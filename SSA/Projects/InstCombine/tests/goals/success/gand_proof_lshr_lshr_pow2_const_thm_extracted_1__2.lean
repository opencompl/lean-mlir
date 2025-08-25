
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_lshr_pow2_const_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → ¬ofBool (x == 3#16) = 1#1 → 2048#16 >>> x >>> 6#16 &&& 4#16 = 0#16 :=
sorry