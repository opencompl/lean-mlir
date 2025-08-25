
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem narrow_zext_ashr_keep_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true ∨ 1#32 ≥ ↑32) →
    True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16 → False :=
sorry