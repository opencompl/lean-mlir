
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem no_reassoc_add_none_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 4#32 = true) → x + 4#32 + 64#32 = x + 68#32 :=
sorry