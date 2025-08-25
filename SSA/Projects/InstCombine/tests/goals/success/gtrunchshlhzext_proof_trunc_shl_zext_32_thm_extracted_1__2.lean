
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_zext_32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬4#16 ≥ ↑16 → ¬4#32 ≥ ↑32 → zeroExtend 32 (truncate 16 x <<< 4#16) = x <<< 4#32 &&& 65520#32 :=
sorry