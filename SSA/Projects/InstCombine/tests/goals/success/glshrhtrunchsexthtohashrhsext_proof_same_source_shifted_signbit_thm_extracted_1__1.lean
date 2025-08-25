
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem same_source_shifted_signbit_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → signExtend 32 (truncate 8 (x >>> 24#32)) = x.sshiftRight' 24#32 :=
sorry