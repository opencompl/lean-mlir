
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_shl_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → x <<< 7#8 ^^^ BitVec.ofInt 8 (-128) = (x ^^^ -1#8) <<< 7#8 :=
sorry