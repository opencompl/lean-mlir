
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_nuw_31_i32_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x <<< 31#64 >>> 31#64 ≠ x ∨ 31#64 ≥ ↑64) →
    ¬31#32 ≥ ↑32 → truncate 32 (x <<< 31#64) = truncate 32 x <<< 31#32 :=
sorry