
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 6#8 ≥ ↑8) →
    ¬(30#32 ≥ ↑32 ∨ True ∧ x <<< 30#32 >>> 30#32 <<< 30#32 ≠ x <<< 30#32 ∨ 30#32 ≥ ↑32) →
      signExtend 32 ((truncate 8 x <<< 6#8).sshiftRight' 6#8) = (x <<< 30#32).sshiftRight' 30#32 :=
sorry