
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬31#32 - x ≥ ↑32 →
    ¬(True ∧ BitVec.ofInt 32 (-2147483648) >>> x <<< x ≠ BitVec.ofInt 32 (-2147483648) ∨ x ≥ ↑32) →
      1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x :=
sorry