
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 57),
  ¬(x_1 ≥ ↑57 ∨ x_1 ≥ ↑57) → ¬x_1 ≥ ↑57 → x_2 >>> x_1 ||| x >>> x_1 = (x_2 ||| x) >>> x_1 :=
sorry