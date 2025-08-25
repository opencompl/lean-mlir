
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_and_xor_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) → ¬1#8 ≥ ↑8 → x_1 <<< 1#8 ^^^ x <<< 1#8 &&& 20#8 = (x_1 ^^^ x &&& 10#8) <<< 1#8 :=
sorry