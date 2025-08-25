
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_shl_constants_div_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ 2#32 ≥ ↑32 ∨ 1#32 <<< x <<< 2#32 = 0) →
    ¬x + 2#32 ≥ ↑32 → x_1 / 1#32 <<< x <<< 2#32 = x_1 >>> (x + 2#32) :=
sorry