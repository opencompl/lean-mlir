
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr51551_2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7) ||| 1#32).smulOverflow x = true) →
    ofBool ((x_1 &&& BitVec.ofInt 32 (-7) ||| 1#32) * x &&& 1#32 == 0#32) = ofBool (x &&& 1#32 == 0#32) :=
sorry