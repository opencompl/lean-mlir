
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr51551_demand3bits_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-7) ||| 1#32).smulOverflow x = true) →
    (x_1 &&& BitVec.ofInt 32 (-7) ||| 1#32) * x &&& 7#32 = x &&& 7#32 :=
sorry