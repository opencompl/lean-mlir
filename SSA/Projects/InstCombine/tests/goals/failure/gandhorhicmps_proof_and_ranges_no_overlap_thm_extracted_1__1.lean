
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_ranges_no_overlap_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (5#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 10#8) &&& (ofBool (11#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 20#8)) = 0#1 :=
sorry