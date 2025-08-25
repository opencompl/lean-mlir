
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_mul_times_3_div_2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 3#32 = true ∨ True ∧ x.umulOverflow 3#32 = true ∨ 1#32 ≥ ↑32) →
    ¬(1#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x >>> 1#32) = true ∨ True ∧ x.uaddOverflow (x >>> 1#32) = true) →
      (x * 3#32).sshiftRight' 1#32 = x + x >>> 1#32 :=
sorry