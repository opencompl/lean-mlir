
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr51551_neg2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7)).smulOverflow x = true) →
    ¬truncate 1 x_1 ^^^ 1#1 = 1#1 →
      ofBool ((x_1 &&& BitVec.ofInt 32 (-7)) * x &&& 7#32 == 0#32) = ofBool (x &&& 7#32 == 0#32) :=
sorry