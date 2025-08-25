
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test17_thm.extracted_1._1 : ∀ (x : BitVec 106),
  ¬3#106 ≥ ↑106 → ofBool (x >>> 3#106 == 1234#106) = ofBool (x &&& BitVec.ofInt 106 (-8) == 9872#106) :=
sorry