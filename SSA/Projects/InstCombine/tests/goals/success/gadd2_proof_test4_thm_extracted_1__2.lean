
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow x = true) → ¬(True ∧ x <<< 1#32 >>> 1#32 ≠ x ∨ 1#32 ≥ ↑32) → x + x = x <<< 1#32 :=
sorry