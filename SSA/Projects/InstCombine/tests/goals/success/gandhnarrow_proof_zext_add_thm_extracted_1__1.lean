
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_add_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 16 x + 44#16 &&& zeroExtend 16 x = zeroExtend 16 (x + 44#8 &&& x) :=
sorry