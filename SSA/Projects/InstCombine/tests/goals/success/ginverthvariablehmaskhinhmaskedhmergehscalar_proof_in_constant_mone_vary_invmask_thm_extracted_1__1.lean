
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem in_constant_mone_vary_invmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  (-1#4 ^^^ x_1) &&& (x ^^^ -1#4) ^^^ x_1 = x_1 ||| x ^^^ -1#4 :=
sorry