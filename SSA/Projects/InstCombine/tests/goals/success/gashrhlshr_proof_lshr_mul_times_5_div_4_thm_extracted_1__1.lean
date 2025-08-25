
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_times_5_div_4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 5#32 = true ∨ True ∧ x.umulOverflow 5#32 = true ∨ 2#32 ≥ ↑32) →
    2#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x >>> 2#32) = true ∨ True ∧ x.uaddOverflow (x >>> 2#32) = true → False :=
sorry