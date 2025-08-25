
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_bigger_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 3#24 ≥ ↑24) →
    9#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 24 (x.sshiftRight' 9#32)) ≠ x.sshiftRight' 9#32 → False :=
sorry