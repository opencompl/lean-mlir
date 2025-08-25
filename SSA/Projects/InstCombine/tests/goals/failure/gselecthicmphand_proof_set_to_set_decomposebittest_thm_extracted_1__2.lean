
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_to_set_decomposebittest_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ofBool (x <ₛ 0#8) = 1#1 →
    ¬(True ∧ (x &&& BitVec.ofInt 8 (-128) &&& 3#8 != 0) = true) →
      BitVec.ofInt 8 (-125) = x &&& BitVec.ofInt 8 (-128) ||| 3#8 :=
sorry