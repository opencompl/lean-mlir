
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬16#32 ≥ ↑32 →
    zeroExtend 32 x <<< 16#32 &&& BitVec.ofInt 32 (-2147483648) = signExtend 32 x &&& BitVec.ofInt 32 (-2147483648) :=
sorry