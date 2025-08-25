
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_sgt_overflow_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (63#8 <ₛ x.sshiftRight' 1#8) = 0#1 :=
sorry