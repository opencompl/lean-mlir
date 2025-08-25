
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_pow2_const_case1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → ¬ofBool (x == 7#16) = 1#1 → 4#16 <<< x >>> 6#16 &&& 8#16 = 0#16 :=
sorry