
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_pow2_not_const_case2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 3#16 ≥ ↑16) → ofBool (x == 2#16) = 1#1 → 16#16 <<< x >>> 3#16 &&& 8#16 ^^^ 8#16 = 0#16 :=
sorry