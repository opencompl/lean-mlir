
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_and_icmps1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ofBool (-1#32 <ₛ x) = 1#1 → ofBool (x <ₛ 10086#32) = ofBool (x <ᵤ 10086#32) :=
sorry