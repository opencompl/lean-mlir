
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_c_i32_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬zeroExtend 32 x = 0 → ¬(x = 0 ∨ True ∧ (10#8 % x).msb = true) → 10#32 % zeroExtend 32 x = zeroExtend 32 (10#8 % x) :=
sorry