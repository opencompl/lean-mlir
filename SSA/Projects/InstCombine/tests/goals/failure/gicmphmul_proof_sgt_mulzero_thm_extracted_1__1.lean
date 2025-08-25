
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_mulzero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smulOverflow 0#8 = true) → ofBool (21#8 <ₛ x * 0#8) = 0#1 :=
sorry