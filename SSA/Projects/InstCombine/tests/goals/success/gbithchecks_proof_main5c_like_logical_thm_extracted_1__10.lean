
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5c_like_logical_thm.extracted_1._10 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 7#32 != 7#32) = 1#1 →
    ofBool (x_1 &&& 7#32 == 7#32) = 1#1 →
      ¬ofBool (x &&& 7#32 != 7#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x &&& 7#32 == 7#32)) :=
sorry