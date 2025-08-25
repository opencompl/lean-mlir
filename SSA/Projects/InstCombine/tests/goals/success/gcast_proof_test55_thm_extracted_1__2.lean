
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test55_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 7224#16 &&& BitVec.ofInt 16 (-32574) != 0) = true) →
    signExtend 64 ((truncate 16 x ||| BitVec.ofInt 16 (-32574)) &&& BitVec.ofInt 16 (-25350)) =
      signExtend 64 (truncate 16 x &&& 7224#16 ||| BitVec.ofInt 16 (-32574)) :=
sorry