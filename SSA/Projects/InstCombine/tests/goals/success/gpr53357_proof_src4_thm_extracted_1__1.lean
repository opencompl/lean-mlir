
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32), (x_1 &&& x) + ((x ||| x_1) ^^^ -1#32) = x_1 ^^^ x ^^^ -1#32 :=
sorry