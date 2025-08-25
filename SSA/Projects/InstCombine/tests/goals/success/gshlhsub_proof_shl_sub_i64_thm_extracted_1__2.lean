
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_i64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 - x ≥ ↑64 →
    ¬(True ∧ BitVec.ofInt 64 (-9223372036854775808) >>> x <<< x ≠ BitVec.ofInt 64 (-9223372036854775808) ∨ x ≥ ↑64) →
      1#64 <<< (63#64 - x) = BitVec.ofInt 64 (-9223372036854775808) >>> x :=
sorry