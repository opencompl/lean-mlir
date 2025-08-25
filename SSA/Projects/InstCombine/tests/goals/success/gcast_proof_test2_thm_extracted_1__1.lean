
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 64 (zeroExtend 32 (zeroExtend 16 x)) = zeroExtend 64 x :=
sorry