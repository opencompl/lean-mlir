
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_reassoc_add_nuw_none_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x + 4#32).uaddOverflow 64#32 = true) → x + 4#32 + 64#32 = x + 68#32 :=
sorry