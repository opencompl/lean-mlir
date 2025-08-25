
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem testtrunclowhigh_thm.extracted_1._3 : ∀ (x x_1 : BitVec 16) (x_2 : BitVec 32),
  ¬ofBool (x_2 + 128#32 <ᵤ 256#32) = 1#1 → ofBool (-1#32 <ₛ x_2) = 1#1 → ofBool (x_2 <ₛ 0#32) = 1#1 → x_1 = x :=
sorry