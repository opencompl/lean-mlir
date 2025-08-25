
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n4_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬16#32 ≥ ↑32 → True ∧ zeroExtend 32 x <<< 16#32 >>> 16#32 ≠ zeroExtend 32 x ∨ 16#32 ≥ ↑32 → False :=
sorry