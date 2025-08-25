
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_shl_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  ¬x ≥ ↑4 → 0#4 - (x_1 ^^^ 5#4) <<< x = ((x_1 ^^^ BitVec.ofInt 4 (-6)) + 1#4) <<< x :=
sorry