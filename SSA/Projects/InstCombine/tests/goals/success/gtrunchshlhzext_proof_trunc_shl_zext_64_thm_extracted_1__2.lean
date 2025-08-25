
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_zext_64_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬7#8 ≥ ↑8 → ¬7#64 ≥ ↑64 → zeroExtend 64 (truncate 8 x <<< 7#8) = x <<< 7#64 &&& 128#64 :=
sorry