
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_constant_dividend_select_of_constants_divisor_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬BitVec.ofInt 32 (-3) = 0 → 42#32 % BitVec.ofInt 32 (-3) = 42#32 :=
sorry