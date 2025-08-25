
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬15#32 ≥ ↑32 → zeroExtend 32 x <<< 15#32 &&& BitVec.ofInt 32 (-2147483648) = 0#32 :=
sorry