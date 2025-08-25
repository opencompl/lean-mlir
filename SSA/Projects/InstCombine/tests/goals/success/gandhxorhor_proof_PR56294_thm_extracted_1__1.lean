
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR56294_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 (ofBool (x == 2#8)) &&& zeroExtend 32 (x &&& 1#8) != 0#32) = 0#1 :=
sorry