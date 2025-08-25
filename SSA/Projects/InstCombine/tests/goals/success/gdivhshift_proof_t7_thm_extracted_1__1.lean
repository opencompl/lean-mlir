
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t7_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 2#32).sshiftRight' 2#32 ≠ x ∨
        2#32 ≥ ↑32 ∨ (x == 0 || 32 != 1 && x <<< 2#32 == intMin 32 && x == -1) = true) →
    (x <<< 2#32).sdiv x = 4#32 :=
sorry