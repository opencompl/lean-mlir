
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_sext_multiuse_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_2 <ₛ x_3) = 1#1 →
    (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x_1) + (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x) = 0#32 :=
sorry