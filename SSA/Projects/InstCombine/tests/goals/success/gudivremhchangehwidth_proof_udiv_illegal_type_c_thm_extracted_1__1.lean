
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_illegal_type_c_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬10#32 = 0 → 10#9 = 0 ∨ True ∧ (x / 10#9).msb = true → False :=
sorry