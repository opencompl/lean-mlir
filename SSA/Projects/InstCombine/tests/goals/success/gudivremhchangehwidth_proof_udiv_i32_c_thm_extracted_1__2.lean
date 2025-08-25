
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_i32_c_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬10#32 = 0 → ¬(10#8 = 0 ∨ True ∧ (x / 10#8).msb = true) → zeroExtend 32 x / 10#32 = zeroExtend 32 (x / 10#8) :=
sorry