
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_pair_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x <<< 2#32 >>> 2#32 ≠ x ∨ 2#32 ≥ ↑32 ∨ True ∧ x <<< 1#32 >>> 1#32 ≠ x ∨ 1#32 ≥ ↑32 ∨ x <<< 1#32 = 0) →
    x <<< 2#32 / x <<< 1#32 = 2#32 :=
sorry