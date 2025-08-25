
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_flipped_wrong_bounds_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (BitVec.ofInt 32 (-12) ≤ᵤ x) = 1#1 → ¬ofBool (BitVec.ofInt 32 (-13) <ᵤ x) = 1#1 → -1#32 = x + 9#32 :=
sorry