
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_demand3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    x ≥ ↑8 ∨
        True ∧ 40#8 <<< x >>> 3#8 <<< 3#8 ≠ 40#8 <<< x ∨
          3#8 ≥ ↑8 ∨ True ∧ (40#8 <<< x >>> 3#8 &&& BitVec.ofInt 8 (-64) != 0) = true →
      False :=
sorry