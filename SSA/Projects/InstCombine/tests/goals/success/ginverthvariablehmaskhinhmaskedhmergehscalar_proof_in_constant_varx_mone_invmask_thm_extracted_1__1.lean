
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem in_constant_varx_mone_invmask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  (x_1 ^^^ -1#4) &&& (x ^^^ -1#4) ^^^ -1#4 = x_1 ||| x :=
sorry