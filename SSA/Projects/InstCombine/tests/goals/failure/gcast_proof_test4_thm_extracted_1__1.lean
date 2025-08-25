
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (zeroExtend 8 (ofBool (x_1 <ₛ x))) = zeroExtend 32 (ofBool (x_1 <ₛ x)) :=
sorry