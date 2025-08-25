
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_pow2_const_negative_overflow1_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → 4096#16 <<< x >>> 6#16 &&& 8#16 = 0#16 :=
sorry