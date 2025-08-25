
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test73_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x) = 1#1 → ¬ofBool (x &&& 128#32 == 0#32) = 1#1 → 40#32 = 42#32 :=
sorry