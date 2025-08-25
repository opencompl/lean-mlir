
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_or_sub_comb_i32_commuted1_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (0#32 - x ||| x).uaddOverflow x = true) → (0#32 - x ||| x) + x = x :=
sorry