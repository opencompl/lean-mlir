
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_splat_fold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 65537#32 = true ∨ 16#32 ≥ ↑32) → (x * 65537#32) >>> 16#32 = x :=
sorry