
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_lshr_pow2_const_negative_nopow2_1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → ¬x ≥ ↑16 → 2047#16 >>> x >>> 6#16 &&& 4#16 = 31#16 >>> x &&& 4#16 :=
sorry