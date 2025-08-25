
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_sel_equal_sext_thm.extracted_1._2 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → 16#32 ≥ ↑32 ∨ True ∧ x <<< 16#32 >>> 16#32 <<< 16#32 ≠ x <<< 16#32 ∨ 16#32 ≥ ↑32 → False :=
sorry