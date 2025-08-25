
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3a_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(BitVec.ofInt 32 (-8) == 0 || 32 != 1 && x == intMin 32 && BitVec.ofInt 32 (-8) == -1) = true →
    ofBool (x.srem (BitVec.ofInt 32 (-8)) != 0#32) = ofBool (x &&& 7#32 != 0#32) :=
sorry