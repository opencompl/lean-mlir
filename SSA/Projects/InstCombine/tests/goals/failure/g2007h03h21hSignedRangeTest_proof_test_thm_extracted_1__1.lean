
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 == 0 || 32 != 1 && x == intMin 32 && 12#32 == -1) = true →
    ofBool (x.sdiv 12#32 != BitVec.ofInt 32 (-6)) = ofBool (x + 71#32 <ᵤ BitVec.ofInt 32 (-12)) :=
sorry