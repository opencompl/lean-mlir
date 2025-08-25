
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t20_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ¬x ≥ ↑16 → x_1 - truncate 8 (BitVec.ofInt 16 (-42) <<< x) = x_1 + truncate 8 (42#16 <<< x) :=
sorry