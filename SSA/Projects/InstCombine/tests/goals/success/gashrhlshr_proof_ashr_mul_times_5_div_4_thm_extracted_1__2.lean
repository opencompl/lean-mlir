
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_mul_times_5_div_4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smulOverflow 5#32 = true ∨ True ∧ x.umulOverflow 5#32 = true ∨ 2#32 ≥ ↑32) →
    ¬(2#32 ≥ ↑32 ∨ True ∧ x.saddOverflow (x >>> 2#32) = true ∨ True ∧ x.uaddOverflow (x >>> 2#32) = true) →
      (x * 5#32).sshiftRight' 2#32 = x + x >>> 2#32 :=
sorry