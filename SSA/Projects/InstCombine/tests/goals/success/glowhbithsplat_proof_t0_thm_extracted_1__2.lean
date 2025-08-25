
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(7#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(True ∧ (0#8).ssubOverflow (x &&& 1#8) = true) → (x <<< 7#8).sshiftRight' 7#8 = 0#8 - (x &&& 1#8) :=
sorry