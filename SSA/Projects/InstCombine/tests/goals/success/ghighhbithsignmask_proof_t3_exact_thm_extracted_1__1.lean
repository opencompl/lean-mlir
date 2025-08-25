
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_exact_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) → 0#64 - x.sshiftRight' 63#64 = x >>> 63#64 :=
sorry