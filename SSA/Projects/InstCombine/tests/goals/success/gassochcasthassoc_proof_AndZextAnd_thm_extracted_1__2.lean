
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem AndZextAnd_thm.extracted_1._2 : ∀ (x : BitVec 3),
  ¬(True ∧ (x &&& 2#3).msb = true) → zeroExtend 5 (x &&& 3#3) &&& 14#5 = zeroExtend 5 (x &&& 2#3) :=
sorry