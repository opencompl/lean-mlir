
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test19_thm.extracted_1._2 : ∀ (x : BitVec 10),
  ¬(2#3 ≥ ↑3 ∨ 2#3 ≥ ↑3) →
    ¬(True ∧ (0#3).ssubOverflow (truncate 3 x &&& 1#3) = true) →
      signExtend 10 ((truncate 3 x <<< 2#3).sshiftRight' 2#3) = signExtend 10 (0#3 - (truncate 3 x &&& 1#3)) :=
sorry