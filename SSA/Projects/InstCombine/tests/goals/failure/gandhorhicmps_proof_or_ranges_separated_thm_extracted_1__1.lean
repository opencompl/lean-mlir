
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_ranges_separated_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (5#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 10#8) ||| ofBool (12#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 20#8) =
    ofBool (x + BitVec.ofInt 8 (-5) <ᵤ 6#8) ||| ofBool (x + BitVec.ofInt 8 (-12) <ᵤ 9#8) :=
sorry