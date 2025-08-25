
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test26_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ (1#32 <<< x == 0 || 32 != 1 && x_1 == intMin 32 && 1#32 <<< x == -1) = true) →
    ¬(True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32) →
      ofBool (x_1.srem (1#32 <<< x) != 0#32) = ofBool (x_1 &&& ((-1#32) <<< x ^^^ -1#32) != 0#32) :=
sorry