
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 49),
  ¬(11#49 ≥ ↑49 ∨ 4096#49 <<< 11#49 = 0) → x % 4096#49 <<< 11#49 = x &&& 8388607#49 :=
sorry