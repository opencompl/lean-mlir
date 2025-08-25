
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_sge_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool ((x ||| BitVec.ofInt 8 (-128)) ^^^ x_1 * x_1 ≤ₛ x_1 * x_1) =
    ofBool ((x ||| BitVec.ofInt 8 (-128)) ^^^ x_1 * x_1 <ₛ x_1 * x_1) :=
sorry