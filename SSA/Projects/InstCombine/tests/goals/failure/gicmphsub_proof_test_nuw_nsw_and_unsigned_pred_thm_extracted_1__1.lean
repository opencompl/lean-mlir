
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_nuw_nsw_and_unsigned_pred_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (10#64).ssubOverflow x = true ∨ True ∧ (10#64).usubOverflow x = true) →
    ofBool (10#64 - x ≤ᵤ 3#64) = ofBool (6#64 <ᵤ x) :=
sorry