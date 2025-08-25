
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (20000#32).ssubOverflow (x &&& 511#32) = true ∨
      True ∧ (20000#32).usubOverflow (x &&& 511#32) = true ∨ True ∧ (20000#32 - (x &&& 511#32)).msb = true →
    False :=
sorry