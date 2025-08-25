
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (12#16 ≤ᵤ x) &&& (ofBool (x <ᵤ 16#16) ||| ofBool (28#16 ≤ᵤ x)) =
    ofBool (11#16 <ᵤ x &&& BitVec.ofInt 16 (-20)) :=
sorry