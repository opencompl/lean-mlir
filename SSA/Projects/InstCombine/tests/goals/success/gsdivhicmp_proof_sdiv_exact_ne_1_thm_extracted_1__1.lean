
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv_exact_ne_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.smod x ≠ 0 ∨ (x == 0 || 8 != 1 && x_1 == intMin 8 && x == -1) = true) →
    ofBool (x_1.sdiv x == 0#8) = ofBool (x_1 == 0#8) :=
sorry