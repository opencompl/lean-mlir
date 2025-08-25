
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uadd_sat_flipped_wrong_bounds4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (BitVec.ofInt 32 (-8) ≤ᵤ x) = 1#1 → ofBool (BitVec.ofInt 32 (-9) <ᵤ x) = 1#1 → x + 9#32 = -1#32 :=
sorry