
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_smax_simplify2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 127#8 = true) →
    ¬ofBool (BitVec.ofInt 8 (-2) <ₛ x + 127#8) = 1#1 → BitVec.ofInt 8 (-2) = x + 127#8 :=
sorry