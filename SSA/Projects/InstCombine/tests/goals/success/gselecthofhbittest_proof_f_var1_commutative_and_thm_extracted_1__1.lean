
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_var1_commutative_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 → x &&& 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 1#32) != 0#32)) :=
sorry