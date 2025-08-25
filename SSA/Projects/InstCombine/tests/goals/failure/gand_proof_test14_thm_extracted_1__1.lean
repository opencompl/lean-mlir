
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 8), ofBool (x &&& BitVec.ofInt 8 (-128) != 0#8) = ofBool (x <ₛ 0#8) :=
sorry