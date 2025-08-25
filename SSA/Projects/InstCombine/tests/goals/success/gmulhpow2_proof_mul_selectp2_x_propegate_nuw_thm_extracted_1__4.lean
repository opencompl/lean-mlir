
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_selectp2_x_propegate_nuw_thm.extracted_1._4 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (4#8).smulOverflow x = true ∨ True ∧ (4#8).umulOverflow x = true) →
      ¬(True ∧ x <<< 2#8 >>> 2#8 ≠ x ∨ 2#8 ≥ ↑8) → 4#8 * x = x <<< 2#8 :=
sorry