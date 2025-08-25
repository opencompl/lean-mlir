
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_sgt_exact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → ofBool (10#8 <ₛ x.sshiftRight' 3#8) = ofBool (80#8 <ₛ x) :=
sorry