
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5_like_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 7#32 == 7#32) &&& ofBool (x &&& 7#32 == 7#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& 7#32 != 7#32)) :=
sorry