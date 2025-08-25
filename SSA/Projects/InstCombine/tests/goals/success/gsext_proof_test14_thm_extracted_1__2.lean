
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(4#16 ≥ ↑16 ∨ True ∧ (x >>> 4#16 &&& 1#16).saddOverflow (-1#16) = true) →
    signExtend 32 (ofBool (x &&& 16#16 != 16#16)) = signExtend 32 ((x >>> 4#16 &&& 1#16) + -1#16) :=
sorry