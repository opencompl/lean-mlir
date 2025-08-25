
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_splat_fold_too_narrow_thm.extracted_1._1 : ∀ (x : BitVec 2),
  ¬(True ∧ x.umulOverflow (BitVec.ofInt 2 (-2)) = true ∨ 1#2 ≥ ↑2) → (x * BitVec.ofInt 2 (-2)) >>> 1#2 = x :=
sorry