
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 1#8 <<< 1#8 ≠ x ∨ 1#8 ≥ ↑8) → ofBool (x.sshiftRight' 1#8 == 5#8) = ofBool (x == 10#8) :=
sorry