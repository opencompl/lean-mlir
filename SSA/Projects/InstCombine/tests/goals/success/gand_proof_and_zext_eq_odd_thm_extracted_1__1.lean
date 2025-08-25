
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_eq_odd_thm.extracted_1._1 : ∀ (x : BitVec 32),
  x &&& zeroExtend 32 (ofBool (x == 3#32)) = zeroExtend 32 (ofBool (x == 3#32)) :=
sorry