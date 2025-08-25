
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_shl_icmp_bad_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == 1#32) = 1#1 → ¬x_2 ≥ ↑32 → ¬1#32 ≥ ↑32 → x_1 <<< x_2 = x_1 <<< 1#32 :=
sorry