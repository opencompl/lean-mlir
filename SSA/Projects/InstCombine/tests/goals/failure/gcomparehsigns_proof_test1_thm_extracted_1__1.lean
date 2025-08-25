
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (x_1 <ₛ 0#32) ^^^ ofBool (-1#32 <ₛ x)) = zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
sorry