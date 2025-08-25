
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_1_impliesF_eq_1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ᵤ 1#8) = 1#1 → ofBool (x != 0#8) = 1#1 → False :=
sorry