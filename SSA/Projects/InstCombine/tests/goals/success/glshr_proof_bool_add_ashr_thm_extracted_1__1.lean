
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bool_add_ashr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  ¬1#2 ≥ ↑2 → True ∧ (zeroExtend 2 x_1).uaddOverflow (zeroExtend 2 x) = true ∨ 1#2 ≥ ↑2 → False :=
sorry