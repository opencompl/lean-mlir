
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 7#32 ≥ ↑32) → ¬12#32 ≥ ↑32 → (x.sshiftRight' 5#32).sshiftRight' 7#32 = x.sshiftRight' 12#32 :=
sorry