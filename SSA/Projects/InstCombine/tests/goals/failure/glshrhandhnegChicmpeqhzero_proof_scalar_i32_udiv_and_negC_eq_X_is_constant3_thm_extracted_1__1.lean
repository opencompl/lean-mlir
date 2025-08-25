
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_udiv_and_negC_eq_X_is_constant3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x = 0 → ofBool (12345#32 / x &&& 16376#32 != 0#32) = ofBool (x <ᵤ 1544#32) :=
sorry