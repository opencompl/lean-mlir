
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_var1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 1#32) != 0#32)) :=
sorry