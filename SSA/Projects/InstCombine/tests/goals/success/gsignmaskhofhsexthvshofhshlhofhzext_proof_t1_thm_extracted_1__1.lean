
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬24#32 ≥ ↑32 →
    zeroExtend 32 x <<< 24#32 &&& BitVec.ofInt 32 (-2147483648) = signExtend 32 x &&& BitVec.ofInt 32 (-2147483648) :=
sorry