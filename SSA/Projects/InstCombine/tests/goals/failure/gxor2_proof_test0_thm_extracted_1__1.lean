
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#32 <ₛ x ^^^ BitVec.ofInt 32 (-2147483648)) = ofBool (x <ₛ 0#32) :=
sorry