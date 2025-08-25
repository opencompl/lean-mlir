
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test25_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(BitVec.ofInt 32 (-2147483648) == 0 || 32 != 1 && x == intMin 32 && BitVec.ofInt 32 (-2147483648) == -1) = true →
    ofBool (x.srem (BitVec.ofInt 32 (-2147483648)) != 0#32) = ofBool (x &&& 2147483647#32 != 0#32) :=
sorry