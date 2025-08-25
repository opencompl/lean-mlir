
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_sle_x_negy_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool ((x_1 ||| BitVec.ofInt 8 (-128)) &&& x ≤ₛ x) = 1#1 :=
sorry