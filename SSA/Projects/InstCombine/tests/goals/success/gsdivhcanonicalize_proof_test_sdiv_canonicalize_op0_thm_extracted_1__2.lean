
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sdiv_canonicalize_op0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (0#32).ssubOverflow x_1 = true ∨ (x == 0 || 32 != 1 && 0#32 - x_1 == intMin 32 && x == -1) = true) →
    ¬((x == 0 || 32 != 1 && x_1 == intMin 32 && x == -1) = true ∨ True ∧ (0#32).ssubOverflow (x_1.sdiv x) = true) →
      (0#32 - x_1).sdiv x = 0#32 - x_1.sdiv x :=
sorry