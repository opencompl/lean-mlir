
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_redundant_and_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.msb = true) → zeroExtend 32 x &&& 127#32 = zeroExtend 32 x :=
sorry