
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_slt_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → ofBool (x.sshiftRight' 3#8 <ₛ 10#8) = ofBool (x <ₛ 80#8) :=
sorry