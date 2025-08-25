
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ult_exact_near_pow2_cmpval_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 1#8 <<< 1#8 ≠ x ∨ 1#8 ≥ ↑8) → ofBool (x.sshiftRight' 1#8 <ᵤ 5#8) = ofBool (x <ᵤ 9#8) :=
sorry