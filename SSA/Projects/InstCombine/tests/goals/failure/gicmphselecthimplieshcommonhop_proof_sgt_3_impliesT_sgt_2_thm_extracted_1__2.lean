
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_3_impliesT_sgt_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ofBool (3#8 <ₛ x) = 1#1 → ¬ofBool (x <ₛ 4#8) = 1#1 → ofBool (x <ₛ 2#8) = 0#1 :=
sorry