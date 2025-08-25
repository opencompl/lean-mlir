
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 19),
  ¬(18#19 ≥ ↑19 ∨ 18#19 ≥ ↑19) → x >>> 18#19 <<< 18#19 = x &&& BitVec.ofInt 19 (-262144) :=
sorry