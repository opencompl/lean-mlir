
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(True ∧ (x_1 ^^^ -1#32).msb = true) →
    x_2 + BitVec.ofInt 64 (-5) - (zeroExtend 64 (x_1 ^^^ -1#32) + x) =
      x_2 + BitVec.ofInt 64 (-4) + (signExtend 64 x_1 - x) :=
sorry