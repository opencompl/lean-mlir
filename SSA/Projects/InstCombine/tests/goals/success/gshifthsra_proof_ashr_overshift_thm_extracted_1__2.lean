
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_overshift_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(15#32 ≥ ↑32 ∨ 17#32 ≥ ↑32) → ¬31#32 ≥ ↑32 → (x.sshiftRight' 15#32).sshiftRight' 17#32 = x.sshiftRight' 31#32 :=
sorry