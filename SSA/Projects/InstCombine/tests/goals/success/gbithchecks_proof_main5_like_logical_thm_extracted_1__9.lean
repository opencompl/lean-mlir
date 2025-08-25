
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5_like_logical_thm.extracted_1._9 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 == 7#32) = 1#1 → ofBool (x_1 &&& 7#32 != 7#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
sorry