
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_constmask2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 61440#32 &&& (x &&& BitVec.ofInt 32 (-65281)) != 0) = true) →
    x_1 &&& 61440#32 ^^^ x &&& BitVec.ofInt 32 (-65281) = x_1 &&& 61440#32 ||| x &&& BitVec.ofInt 32 (-65281) :=
sorry