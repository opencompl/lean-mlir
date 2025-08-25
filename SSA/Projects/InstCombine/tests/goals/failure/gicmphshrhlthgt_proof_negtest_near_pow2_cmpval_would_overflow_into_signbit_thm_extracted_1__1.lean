
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negtest_near_pow2_cmpval_would_overflow_into_signbit_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 2#8 <<< 2#8 ≠ x ∨ 2#8 ≥ ↑8) → ofBool (x.sshiftRight' 2#8 <ᵤ 33#8) = ofBool (-1#8 <ₛ x) :=
sorry