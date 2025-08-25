
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_and_add_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) →
    1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8 ∨ True ∧ (x_1 >>> 1#8).uaddOverflow (x >>> 1#8 &&& 123#8) = true → False :=
sorry