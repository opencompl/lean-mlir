
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test25_thm.extracted_1._1 : ∀ (x x_1 : BitVec 37),
  ¬(17#37 ≥ ↑37 ∨ 17#37 ≥ ↑37 ∨ 17#37 ≥ ↑37) →
    (x_1 >>> 17#37 + x >>> 17#37) <<< 17#37 = x + (x_1 &&& BitVec.ofInt 37 (-131072)) &&& BitVec.ofInt 37 (-131072) :=
sorry