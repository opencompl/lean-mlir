
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_umax_simplify2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 57#32 = true) → ¬ofBool (56#32 <ᵤ x + 57#32) = 1#1 → 56#32 = x + 57#32 :=
sorry