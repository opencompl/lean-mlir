
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem twoway_clamp_lt_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 13768#32) = 1#1 → ofBool (13767#32 <ₛ x) = 1#1 → x = 13768#32 :=
sorry