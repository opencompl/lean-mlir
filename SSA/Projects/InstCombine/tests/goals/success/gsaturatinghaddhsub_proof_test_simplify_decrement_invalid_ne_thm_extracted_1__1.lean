
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_simplify_decrement_invalid_ne_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x != 0#8) = 1#1 → 0#8 = signExtend 8 (ofBool (x == 0#8)) :=
sorry