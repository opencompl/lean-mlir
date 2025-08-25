
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& BitVec.ofInt 32 (-2147483648) == (x ^^^ -1#32) &&& BitVec.ofInt 32 (-2147483648)) =
    ofBool (x ^^^ x_1 <ₛ 0#32) :=
sorry