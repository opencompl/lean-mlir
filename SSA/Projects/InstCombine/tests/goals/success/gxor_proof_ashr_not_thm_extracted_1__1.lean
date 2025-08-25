
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_not_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → (x ^^^ -1#8).sshiftRight' 5#8 = x.sshiftRight' 5#8 ^^^ -1#8 :=
sorry