
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 → ¬7#8 ≥ ↑8 → (signExtend 32 x).sshiftRight' 8#32 = signExtend 32 (x.sshiftRight' 7#8) :=
sorry