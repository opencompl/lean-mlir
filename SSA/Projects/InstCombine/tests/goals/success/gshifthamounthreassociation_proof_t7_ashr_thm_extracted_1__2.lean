
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_ashr_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 >>> (32#32 - x) <<< (32#32 - x) ≠ x_1 ∨ 32#32 - x ≥ ↑32 ∨ x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    ¬30#32 ≥ ↑32 → (x_1.sshiftRight' (32#32 - x)).sshiftRight' (x + BitVec.ofInt 32 (-2)) = x_1.sshiftRight' 30#32 :=
sorry