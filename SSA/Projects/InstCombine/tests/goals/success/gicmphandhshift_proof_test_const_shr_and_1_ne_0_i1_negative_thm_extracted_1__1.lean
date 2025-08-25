
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_const_shr_and_1_ne_0_i1_negative_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x ≥ 1 → ofBool (1#1 >>> x &&& 1#1 != 0#1) = 1#1 :=
sorry