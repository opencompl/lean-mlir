
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_mul_times_3_div_2_exact_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 3#32 = true ∨ True ∧ (x * 3#32) >>> 1#32 <<< 1#32 ≠ x * 3#32 ∨ 1#32 ≥ ↑32) →
    True ∧ x >>> 1#32 <<< 1#32 ≠ x ∨ 1#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x.sshiftRight' 1#32) = true → False :=
sorry