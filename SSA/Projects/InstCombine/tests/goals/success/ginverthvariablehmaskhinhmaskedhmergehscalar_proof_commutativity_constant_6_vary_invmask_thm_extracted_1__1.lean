
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem commutativity_constant_6_vary_invmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  (x_1 ^^^ -1#4) &&& (x ^^^ 6#4) ^^^ x = (x ^^^ 6#4) &&& x_1 ^^^ 6#4 :=
sorry