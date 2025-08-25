
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smod 3#32 ≠ 0 ∨ (3#32 == 0 || 32 != 1 && x == intMin 32 && 3#32 == -1) = true) → x.sdiv 3#32 * 3#32 = x :=
sorry