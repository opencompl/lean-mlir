
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n3_constmask_samemask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  x_1 &&& 65280#32 ^^^ x &&& 65280#32 = (x_1 ^^^ x) &&& 65280#32 :=
sorry