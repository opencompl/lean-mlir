
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 17),
  ¬(8#37 ≥ ↑37 ∨ 8#37 ≥ ↑37) →
    ¬(8#17 ≥ ↑17 ∨ 8#17 ≥ ↑17) →
      truncate 17 (zeroExtend 37 x >>> 8#37 ||| zeroExtend 37 x <<< 8#37) = x >>> 8#17 ||| x <<< 8#17 :=
sorry