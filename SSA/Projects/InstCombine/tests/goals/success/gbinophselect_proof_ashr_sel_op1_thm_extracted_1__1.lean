
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_sel_op1_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → ¬2#32 ≥ ↑32 → (BitVec.ofInt 32 (-2)).sshiftRight' 2#32 = -1#32 :=
sorry