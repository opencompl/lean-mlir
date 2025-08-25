
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_add_udiv_urem_or_disjoint_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(10#32 = 0 ∨ 4#32 ≥ ↑32 ∨ 10#32 = 0 ∨ True ∧ ((x / 10#32) <<< 4#32 &&& x % 10#32 != 0) = true) →
    10#32 = 0 ∨ True ∧ (x / 10#32).umulOverflow 6#32 = true → False :=
sorry