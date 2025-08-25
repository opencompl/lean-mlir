
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem x_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(65536#32 == 0 || 32 != 1 && x == intMin 32 && 65536#32 == -1) = true →
    ofBool (x.sdiv 65536#32 <ₛ BitVec.ofInt 32 (-65536)) = 0#1 :=
sorry