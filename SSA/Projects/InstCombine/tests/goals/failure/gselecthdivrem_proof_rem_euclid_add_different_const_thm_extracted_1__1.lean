
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem rem_euclid_add_different_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true →
    ofBool (x.srem 8#32 <ₛ 0#32) = 1#1 →
      (8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true ∨ True ∧ (x.srem 8#32).saddOverflow 9#32 = true →
        False :=
sorry