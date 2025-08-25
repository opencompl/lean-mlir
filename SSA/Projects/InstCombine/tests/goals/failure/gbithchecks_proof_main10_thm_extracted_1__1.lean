
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 64#32 == 0#32) &&& ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 →
    ¬ofBool (x &&& 192#32 == 0#32) = 1#1 → 2#32 = 1#32 :=
sorry