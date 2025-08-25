
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem hoist_ashr_ahead_of_sext_1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 → ¬3#8 ≥ ↑8 → (signExtend 32 x).sshiftRight' 3#32 = signExtend 32 (x.sshiftRight' 3#8) :=
sorry