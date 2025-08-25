
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_pow2_const_negative_overflow2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → 8#16 <<< x >>> 6#16 &&& BitVec.ofInt 16 (-32768) = 0#16 :=
sorry