
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_to_clear_decomposebittest_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x <ₛ 0#8) = 1#1 → BitVec.ofInt 8 (-125) = x &&& BitVec.ofInt 8 (-128) ^^^ BitVec.ofInt 8 (-125) :=
sorry