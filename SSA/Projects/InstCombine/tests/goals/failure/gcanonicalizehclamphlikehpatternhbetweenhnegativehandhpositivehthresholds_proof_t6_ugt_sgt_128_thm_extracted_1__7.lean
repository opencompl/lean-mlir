
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t6_ugt_sgt_128_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (143#32 <ᵤ x_2 + 16#32) = 1#1 →
    ¬ofBool (127#32 <ₛ x_2) = 1#1 → ¬ofBool (x_2 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → x = x_2 :=
sorry