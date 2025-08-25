
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem clear_to_set_decomposebittest_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (-1#8 <ₛ x) = 1#1 → BitVec.ofInt 8 (-125) = x &&& BitVec.ofInt 8 (-128) ^^^ BitVec.ofInt 8 (-125) :=
sorry