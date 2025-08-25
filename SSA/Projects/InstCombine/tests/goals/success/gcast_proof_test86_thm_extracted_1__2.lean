
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test86_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬4#32 ≥ ↑32 → ¬4#16 ≥ ↑16 → truncate 16 ((signExtend 32 x).sshiftRight' 4#32) = x.sshiftRight' 4#16 :=
sorry