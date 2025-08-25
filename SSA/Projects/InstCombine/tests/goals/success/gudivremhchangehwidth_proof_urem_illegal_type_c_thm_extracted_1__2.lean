
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_illegal_type_c_thm.extracted_1._2 : ∀ (x : BitVec 9),
  ¬10#32 = 0 → ¬(10#9 = 0 ∨ True ∧ (x % 10#9).msb = true) → zeroExtend 32 x % 10#32 = zeroExtend 32 (x % 10#9) :=
sorry