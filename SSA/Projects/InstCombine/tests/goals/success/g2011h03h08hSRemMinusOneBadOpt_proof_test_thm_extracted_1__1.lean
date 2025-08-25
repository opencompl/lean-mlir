
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(-1#32 == 0 || 32 != 1 && truncate 32 (x ||| 4294967294#64) == intMin 32 && -1#32 == -1) = true →
    (truncate 32 (x ||| 4294967294#64)).srem (-1#32) = 0#32 :=
sorry