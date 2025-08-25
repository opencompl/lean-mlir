
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_i1_thm.extracted_1._1 : ∀ (x : BitVec 1), ¬(True ∧ x.msb = true) → zeroExtend 32 x = 0#32 :=
sorry