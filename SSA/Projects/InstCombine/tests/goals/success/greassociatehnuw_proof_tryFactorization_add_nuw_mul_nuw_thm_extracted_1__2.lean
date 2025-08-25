
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_add_nuw_mul_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 3#32 = true ∨ True ∧ (x * 3#32).uaddOverflow x = true) →
    ¬(True ∧ x <<< 2#32 >>> 2#32 ≠ x ∨ 2#32 ≥ ↑32) → x * 3#32 + x = x <<< 2#32 :=
sorry