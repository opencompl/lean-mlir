
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_disjoint_with_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& x != 0) = true) → (x_1 ||| x) ^^^ x_1 = x :=
sorry