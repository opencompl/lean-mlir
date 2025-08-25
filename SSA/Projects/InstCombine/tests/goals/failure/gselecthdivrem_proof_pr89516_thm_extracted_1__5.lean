
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr89516_thm.extracted_1._5 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 <ₛ 0#8) = 1#1 →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ (1#8 <<< x == 0 || 8 != 1 && 1#8 == intMin 8 && 1#8 <<< x == -1) = true) →
      ¬(True ∧ ((1#8).srem (1#8 <<< x)).uaddOverflow 0#8 = true) →
        (1#8).srem (1#8 <<< x) = (1#8).srem (1#8 <<< x) + 0#8 :=
sorry