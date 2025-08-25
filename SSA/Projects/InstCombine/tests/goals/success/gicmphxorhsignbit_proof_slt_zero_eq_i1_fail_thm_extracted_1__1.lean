
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_eq_i1_fail_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 →
    ofBool (zeroExtend 32 x_1 == x.sshiftRight' 31#32) = ofBool (x.sshiftRight' 31#32 == zeroExtend 32 x_1) :=
sorry