
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬3#32 = 0 → ¬(3#32 = 0 ∨ True ∧ (x / 3#32).msb = true) → signExtend 64 (x / 3#32) = zeroExtend 64 (x / 3#32) :=
sorry