
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_icmp2_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.umod 5#64 ≠ 0 ∨ 5#64 = 0) → ofBool (x / 5#64 == 0#64) = ofBool (x == 0#64) :=
sorry