
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_and_signbit_lshr_without_shifting_signbit_both_sides_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ x ≥ ↑32) →
    ofBool (-1#32 <ₛ x_2 <<< x_1) ||| ofBool (-1#32 <ₛ x_2 <<< x) = ofBool (-1#32 <ₛ x_2 <<< x_1 &&& x_2 <<< x) :=
sorry