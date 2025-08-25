
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem C0zero_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x + 10#8 <ᵤ 0#8) = 1#1 → ofBool (x <ₛ BitVec.ofInt 8 (-10)) = 1#1 → False :=
sorry