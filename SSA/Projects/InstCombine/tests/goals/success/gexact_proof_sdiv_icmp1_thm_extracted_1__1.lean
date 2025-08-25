
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_icmp1_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smod 5#64 ≠ 0 ∨ (5#64 == 0 || 64 != 1 && x == intMin 64 && 5#64 == -1) = true) →
    ofBool (x.sdiv 5#64 == 0#64) = ofBool (x == 0#64) :=
sorry