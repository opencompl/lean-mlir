
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_16_add_zext_basic_multiuse_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x_1).saddOverflow (zeroExtend 32 x) = true ∨
        True ∧ (zeroExtend 32 x_1).uaddOverflow (zeroExtend 32 x) = true ∨ 16#32 ≥ ↑32 →
      False :=
sorry