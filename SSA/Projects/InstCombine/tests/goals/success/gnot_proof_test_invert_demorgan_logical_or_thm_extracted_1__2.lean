
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invert_demorgan_logical_or_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ofBool (x == 27#64) = 1#1 →
    ¬ofBool (x != 27#64) = 1#1 → (ofBool (x == 0#64) ||| 1#1) ^^^ 1#1 = ofBool (x != 0#64) &&& 0#1 :=
sorry