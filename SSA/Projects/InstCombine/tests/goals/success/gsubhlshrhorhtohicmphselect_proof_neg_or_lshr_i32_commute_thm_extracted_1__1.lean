
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_or_lshr_i32_commute_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨ 31#32 ≥ ↑32) →
    (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true → False :=
sorry