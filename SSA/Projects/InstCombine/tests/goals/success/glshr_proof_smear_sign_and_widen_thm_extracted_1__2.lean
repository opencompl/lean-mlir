
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem smear_sign_and_widen_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬24#32 ≥ ↑32 → ¬7#8 ≥ ↑8 → signExtend 32 x >>> 24#32 = zeroExtend 32 (x.sshiftRight' 7#8) :=
sorry