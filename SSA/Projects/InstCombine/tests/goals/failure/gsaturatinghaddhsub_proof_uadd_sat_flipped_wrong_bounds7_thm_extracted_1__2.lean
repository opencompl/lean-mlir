
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_flipped_wrong_bounds7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x ≤ᵤ BitVec.ofInt 32 (-12)) = 1#1 → ofBool (x <ᵤ BitVec.ofInt 32 (-11)) = 1#1 → -1#32 = x + 9#32 :=
sorry