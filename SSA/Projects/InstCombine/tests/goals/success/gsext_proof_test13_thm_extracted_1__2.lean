
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ True ∧ (x >>> 3#32 &&& 1#32).saddOverflow (-1#32) = true) →
    signExtend 32 (ofBool (x &&& 8#32 == 0#32)) = (x >>> 3#32 &&& 1#32) + -1#32 :=
sorry