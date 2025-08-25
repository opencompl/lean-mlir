
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test87_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (signExtend 32 x).smulOverflow 16#32 = true ∨ 16#32 ≥ ↑32) → 12#16 ≥ ↑16 → False :=
sorry