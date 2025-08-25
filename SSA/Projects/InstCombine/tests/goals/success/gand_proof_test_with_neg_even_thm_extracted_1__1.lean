
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_with_neg_even_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → BitVec.ofInt 32 (-4) <<< x &&& 1#32 = 0#32 :=
sorry