
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negtest_near_pow2_cmpval_ashr_slt_noexact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (x.sshiftRight' 1#8 <ₛ 5#8) = ofBool (x <ₛ 10#8) :=
sorry