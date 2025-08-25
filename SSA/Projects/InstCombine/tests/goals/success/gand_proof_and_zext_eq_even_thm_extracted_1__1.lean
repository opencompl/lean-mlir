
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_eq_even_thm.extracted_1._1 : ∀ (x : BitVec 32), x &&& zeroExtend 32 (ofBool (x == 2#32)) = 0#32 :=
sorry