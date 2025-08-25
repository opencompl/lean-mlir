
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem C0zero_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 + 10#8 <ᵤ 0#8) = 1#1 → ofBool (x_2 <ₛ BitVec.ofInt 8 (-10)) = 1#1 → x_2 = x_1 :=
sorry