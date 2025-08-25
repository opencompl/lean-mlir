
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_ranges_single_elem_left_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (5#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 10#8) ||| ofBool (x == 4#8) = ofBool (x + BitVec.ofInt 8 (-4) <ᵤ 7#8) :=
sorry