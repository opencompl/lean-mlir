
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem narrow_zext_ashr_keep_trunc2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 9),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    True ∧ (zeroExtend 16 x_1).saddOverflow (zeroExtend 16 x) = true ∨
        True ∧ (zeroExtend 16 x_1).uaddOverflow (zeroExtend 16 x) = true ∨ 1#16 ≥ ↑16 →
      False :=
sorry