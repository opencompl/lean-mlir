
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test88_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬18#32 ≥ ↑32 → ¬15#16 ≥ ↑16 → truncate 16 ((signExtend 32 x).sshiftRight' 18#32) = x.sshiftRight' 15#16 :=
sorry