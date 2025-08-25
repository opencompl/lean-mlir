
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test82_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(8#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    ¬1#32 ≥ ↑32 →
      zeroExtend 64 (truncate 32 x >>> 8#32 <<< 9#32) =
        zeroExtend 64 (truncate 32 x <<< 1#32 &&& BitVec.ofInt 32 (-512)) :=
sorry