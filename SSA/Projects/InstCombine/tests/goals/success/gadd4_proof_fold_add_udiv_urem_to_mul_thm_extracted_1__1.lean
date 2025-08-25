
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_add_udiv_urem_to_mul_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#32 = 0 ∨ 7#32 = 0) → x / 7#32 * 21#32 + x % 7#32 * 3#32 = x * 3#32 :=
sorry