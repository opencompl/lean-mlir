
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ofBool (x &&& BitVec.ofInt 37 (-2147483648) != 0#37) = ofBool (2147483647#37 <ᵤ x) :=
sorry