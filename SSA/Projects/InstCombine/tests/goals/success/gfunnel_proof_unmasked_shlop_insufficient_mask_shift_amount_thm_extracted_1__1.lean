
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem unmasked_shlop_insufficient_mask_shift_amount_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 16),
  ¬(8#16 - (x_1 &&& 15#16) ≥ ↑16 ∨ x_1 &&& 15#16 ≥ ↑16) →
    True ∧ (8#16).ssubOverflow (x_1 &&& 15#16) = true ∨ 8#16 - (x_1 &&& 15#16) ≥ ↑16 ∨ x_1 &&& 15#16 ≥ ↑16 → False :=
sorry