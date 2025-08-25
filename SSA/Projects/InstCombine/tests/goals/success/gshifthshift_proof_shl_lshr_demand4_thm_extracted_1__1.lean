
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_lshr_demand4_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ 3#8 ≥ ↑8) → x ≥ ↑8 ∨ 3#8 ≥ ↑8 ∨ True ∧ (44#8 <<< x >>> 3#8 &&& BitVec.ofInt 8 (-32) != 0) = true → False :=
sorry