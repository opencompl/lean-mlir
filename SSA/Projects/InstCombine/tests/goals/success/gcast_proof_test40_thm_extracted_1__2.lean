
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test40_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(9#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(9#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ True ∧ (x >>> 9#16 &&& x <<< 8#16 != 0) = true) →
      truncate 16 (zeroExtend 32 x >>> 9#32 ||| zeroExtend 32 x <<< 8#32) = x >>> 9#16 ||| x <<< 8#16 :=
sorry