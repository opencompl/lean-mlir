
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 1431655765#32 ^^^ -1#32).saddOverflow 1#32 = true ∨
        True ∧ x.saddOverflow ((x &&& 1431655765#32 ^^^ -1#32) + 1#32) = true) →
    x + ((x &&& 1431655765#32 ^^^ -1#32) + 1#32) = x &&& BitVec.ofInt 32 (-1431655766) :=
sorry