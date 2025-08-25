
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_nuw_and_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x &&& 2#8 ≥ ↑8 →
    True ∧ ((x_1 &&& 31#8) <<< (x &&& 2#8)).sshiftRight' (x &&& 2#8) ≠ x_1 &&& 31#8 ∨
        True ∧ (x_1 &&& 31#8) <<< (x &&& 2#8) >>> (x &&& 2#8) ≠ x_1 &&& 31#8 ∨ x &&& 2#8 ≥ ↑8 →
      False :=
sorry