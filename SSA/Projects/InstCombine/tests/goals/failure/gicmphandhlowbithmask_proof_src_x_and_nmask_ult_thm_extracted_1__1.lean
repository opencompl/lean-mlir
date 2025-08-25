
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_x_and_nmask_ult_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬x = 1#1 → ofBool (x_1 &&& 0#8 <ᵤ 0#8) = 0#1 :=
sorry