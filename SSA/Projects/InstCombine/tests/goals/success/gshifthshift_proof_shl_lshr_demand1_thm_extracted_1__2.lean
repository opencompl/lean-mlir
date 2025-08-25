
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_demand1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) → ¬x ≥ ↑8 → 40#8 <<< x >>> 3#8 ||| BitVec.ofInt 8 (-32) = 5#8 <<< x ||| BitVec.ofInt 8 (-32) :=
sorry