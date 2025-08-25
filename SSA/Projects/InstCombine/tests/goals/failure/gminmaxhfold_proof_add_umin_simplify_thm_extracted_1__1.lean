
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_umin_simplify_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 42#32 = true) → ofBool (x + 42#32 <ᵤ 42#32) = 1#1 → x + 42#32 = 42#32 :=
sorry