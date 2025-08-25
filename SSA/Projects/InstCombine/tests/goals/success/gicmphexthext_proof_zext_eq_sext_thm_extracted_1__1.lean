
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_eq_sext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ofBool (zeroExtend 32 x_1 == signExtend 32 x) = (x_1 ||| x) ^^^ 1#1 :=
sorry