
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem cmpeq_xor_cst1_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 * x_1 == x ^^^ 10#32) = ofBool (x ^^^ x_1 * x_1 == 10#32) :=
sorry