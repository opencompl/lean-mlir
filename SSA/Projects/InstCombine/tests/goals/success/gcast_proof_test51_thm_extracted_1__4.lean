
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test51_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true) →
      signExtend 64 (truncate 32 x ||| 1#32) =
        signExtend 64 (truncate 32 x &&& BitVec.ofInt 32 (-2) ||| zeroExtend 32 (x_1 ^^^ 1#1)) :=
sorry