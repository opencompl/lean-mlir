
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem dec_mask_commute_neg_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true) →
    (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        True ∧ ((42#32).sdiv x).saddOverflow (-1#32) = true ∨
          (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      False :=
sorry