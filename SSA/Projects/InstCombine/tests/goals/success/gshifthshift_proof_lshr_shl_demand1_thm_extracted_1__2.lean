
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_demand1_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) → ¬x ≥ ↑8 → 28#8 >>> x <<< 3#8 ||| 7#8 = BitVec.ofInt 8 (-32) >>> x ||| 7#8 :=
sorry