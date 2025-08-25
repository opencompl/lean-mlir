
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invert_demorgan_or2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  (ofBool (23#64 <ᵤ x_2) ||| ofBool (59#64 <ᵤ x_1) ||| ofBool (59#64 <ᵤ x)) ^^^ 1#1 =
    ofBool (x_2 <ᵤ 24#64) &&& ofBool (x_1 <ᵤ 60#64) &&& ofBool (x <ᵤ 60#64) :=
sorry