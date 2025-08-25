
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_and_odd_eq_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
    ofBool (x.srem 2#32 == 1#32) = ofBool (x &&& BitVec.ofInt 32 (-2147483647) == 1#32) :=
sorry