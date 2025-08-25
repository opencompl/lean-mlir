
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_scalar_urem_by_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬6#32 = 0 → ofBool ((x &&& 128#32) % 6#32 == 0#32) = ofBool (x &&& 128#32 == 0#32) :=
sorry