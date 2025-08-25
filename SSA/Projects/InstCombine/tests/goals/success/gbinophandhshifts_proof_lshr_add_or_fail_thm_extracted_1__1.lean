
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_add_or_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) → 1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8 ∨ True ∧ (x >>> 1#8).uaddOverflow 123#8 = true → False :=
sorry