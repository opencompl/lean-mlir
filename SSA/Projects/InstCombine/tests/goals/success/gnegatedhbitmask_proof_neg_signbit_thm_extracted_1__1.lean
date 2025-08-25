
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_signbit_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 0#32 - zeroExtend 32 (x >>> 7#8) = signExtend 32 (x.sshiftRight' 7#8) :=
sorry