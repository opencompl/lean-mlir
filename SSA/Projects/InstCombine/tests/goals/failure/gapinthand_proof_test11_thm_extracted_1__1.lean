
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 737),
  ofBool (x &&& BitVec.ofInt 737 (-2147483648) != 0#737) = ofBool (2147483647#737 <ᵤ x) :=
sorry