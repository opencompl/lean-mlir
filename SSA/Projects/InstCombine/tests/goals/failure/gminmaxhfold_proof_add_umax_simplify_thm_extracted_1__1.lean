
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_umax_simplify_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ¬(True ∧ x.uaddOverflow 42#37 = true) → ¬ofBool (42#37 <ᵤ x + 42#37) = 1#1 → 42#37 = x + 42#37 :=
sorry