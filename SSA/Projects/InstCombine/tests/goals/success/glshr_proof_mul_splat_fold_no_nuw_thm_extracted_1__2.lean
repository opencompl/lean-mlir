
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_splat_fold_no_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 65537#32 = true ∨ 16#32 ≥ ↑32) →
    ¬(16#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x >>> 16#32) = true) → (x * 65537#32) >>> 16#32 = x + x >>> 16#32 :=
sorry