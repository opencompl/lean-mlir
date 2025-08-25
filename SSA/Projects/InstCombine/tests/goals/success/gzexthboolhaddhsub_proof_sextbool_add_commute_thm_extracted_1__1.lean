
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sextbool_add_commute_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬42#32 = 0 → 42#32 = 0 ∨ True ∧ (x_1 % 42#32).saddOverflow (signExtend 32 x) = true → False :=
sorry