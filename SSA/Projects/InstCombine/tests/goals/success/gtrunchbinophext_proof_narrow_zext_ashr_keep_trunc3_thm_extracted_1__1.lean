
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem narrow_zext_ashr_keep_trunc3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    True ∧ (zeroExtend 14 x_1).saddOverflow (zeroExtend 14 x) = true ∨
        True ∧ (zeroExtend 14 x_1).uaddOverflow (zeroExtend 14 x) = true ∨ 1#14 ≥ ↑14 →
      False :=
sorry