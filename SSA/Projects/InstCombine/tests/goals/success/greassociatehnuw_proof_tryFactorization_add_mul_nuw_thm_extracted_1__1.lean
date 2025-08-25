
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_add_mul_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x * 3#32).uaddOverflow x = true) → 2#32 ≥ ↑32 → False :=
sorry