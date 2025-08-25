
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR52261_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 →
    ¬(True ∧ (0#32).ssubOverflow (BitVec.ofInt 32 (-2)) = true) →
      BitVec.ofInt 32 (-2) &&& 0#32 - BitVec.ofInt 32 (-2) = 2#32 :=
sorry