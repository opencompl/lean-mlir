
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_add_sdiv_srem_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true ∨
        4#32 ≥ ↑32 ∨ (10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true) →
    (10#32 == 0 || 32 != 1 && x == intMin 32 && 10#32 == -1) = true ∨ True ∧ (x.sdiv 10#32).smulOverflow 6#32 = true →
      False :=
sorry