
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_not_signbit3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 7#8 ≥ ↑8 ∨ True ∧ (0#32).ssubOverflow (zeroExtend 32 (x.sshiftRight' 7#8)) = true → False :=
sorry