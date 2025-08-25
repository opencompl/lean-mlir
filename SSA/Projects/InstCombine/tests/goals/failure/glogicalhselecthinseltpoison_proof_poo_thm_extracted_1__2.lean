
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem poo_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 <ₛ x_2) = 1#1 → 0#32 &&& x_1 ||| -1#32 &&& x = x :=
sorry