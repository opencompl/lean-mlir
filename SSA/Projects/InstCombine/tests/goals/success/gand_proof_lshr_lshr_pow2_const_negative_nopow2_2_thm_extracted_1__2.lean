
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_lshr_pow2_const_negative_nopow2_2_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → ¬x ≥ ↑16 → 8192#16 >>> x >>> 6#16 &&& 3#16 = 128#16 >>> x &&& 3#16 :=
sorry