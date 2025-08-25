
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shrink_and_thm.extracted_1._1 : ∀ (x : BitVec 64),
  True ∧ signExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 ∨
      True ∧ zeroExtend 64 (truncate 31 (x &&& 42#64)) ≠ x &&& 42#64 →
    False :=
sorry