
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15i_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2#32 != 0#32) = 1#1 → ¬ofBool (x &&& 2#32 == 0#32) = 1#1 → 1089#32 = 577#32 :=
sorry