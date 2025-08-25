
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main9_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 != 0#32) = 1#1 →
    ¬ofBool (x &&& 192#32 == 192#32) = 1#1 → ofBool (truncate 8 x <ₛ 0#8) = 1#1 → 2#32 = 1#32 :=
sorry