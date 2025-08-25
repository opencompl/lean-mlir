
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_icmp4_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smod (BitVec.ofInt 64 (-5)) ≠ 0 ∨
        (BitVec.ofInt 64 (-5) == 0 || 64 != 1 && x == intMin 64 && BitVec.ofInt 64 (-5) == -1) = true) →
    ofBool (x.sdiv (BitVec.ofInt 64 (-5)) == 0#64) = ofBool (x == 0#64) :=
sorry