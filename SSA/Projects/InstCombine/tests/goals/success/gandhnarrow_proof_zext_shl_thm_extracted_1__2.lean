
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_shl_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#16 ≥ ↑16 → ¬3#8 ≥ ↑8 → zeroExtend 16 x <<< 3#16 &&& zeroExtend 16 x = zeroExtend 16 (x <<< 3#8 &&& x) :=
sorry