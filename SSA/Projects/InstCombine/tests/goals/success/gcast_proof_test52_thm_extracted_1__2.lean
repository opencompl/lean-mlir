
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test52_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    zeroExtend 32 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      zeroExtend 32 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
sorry