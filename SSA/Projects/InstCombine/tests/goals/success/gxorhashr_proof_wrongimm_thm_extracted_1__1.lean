
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem wrongimm_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬14#16 ≥ ↑16 →
    14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 → False :=
sorry