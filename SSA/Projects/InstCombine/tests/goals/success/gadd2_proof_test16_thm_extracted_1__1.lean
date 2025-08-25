
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test16_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow 1#32 = true ∨
        True ∧
          (x_1 + 1#32).saddOverflow (x &&& BitVec.ofInt 32 (-1431655767) ^^^ BitVec.ofInt 32 (-1431655767)) = true) →
    x_1 + 1#32 + (x &&& BitVec.ofInt 32 (-1431655767) ^^^ BitVec.ofInt 32 (-1431655767)) =
      x_1 - (x ||| 1431655766#32) :=
sorry