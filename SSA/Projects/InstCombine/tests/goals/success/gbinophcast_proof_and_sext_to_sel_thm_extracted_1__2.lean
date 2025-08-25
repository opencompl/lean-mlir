
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_sext_to_sel_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 32 x_1 &&& x = 0#32 :=
sorry