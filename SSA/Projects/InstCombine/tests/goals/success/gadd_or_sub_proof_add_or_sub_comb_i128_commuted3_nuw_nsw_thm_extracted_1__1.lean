
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_or_sub_comb_i128_commuted3_nuw_nsw_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ (x * x ||| 0#128 - x * x).saddOverflow (x * x) = true ∨
        True ∧ (x * x ||| 0#128 - x * x).uaddOverflow (x * x) = true) →
    (x * x ||| 0#128 - x * x) + x * x = x * x :=
sorry