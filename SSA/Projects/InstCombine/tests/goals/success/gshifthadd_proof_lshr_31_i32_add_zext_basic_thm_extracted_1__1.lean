
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_31_i32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬31#64 ≥ ↑64 →
    True ∧ (zeroExtend 64 x_1).saddOverflow (zeroExtend 64 x) = true ∨
        True ∧ (zeroExtend 64 x_1).uaddOverflow (zeroExtend 64 x) = true ∨ 31#64 ≥ ↑64 →
      False :=
sorry