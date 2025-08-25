
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr51551_neg1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-3) ||| 1#32).smulOverflow x = true) →
    ¬(True ∧ (x_1 &&& 4#32 &&& 1#32 != 0) = true) →
      ofBool ((x_1 &&& BitVec.ofInt 32 (-3) ||| 1#32) * x &&& 7#32 == 0#32) =
        ofBool ((x_1 &&& 4#32 ||| 1#32) * x &&& 7#32 == 0#32) :=
sorry