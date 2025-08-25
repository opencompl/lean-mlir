
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_exact_poison_constant_fold_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 → 3#8 ≥ ↑8 → ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → False :=
sorry