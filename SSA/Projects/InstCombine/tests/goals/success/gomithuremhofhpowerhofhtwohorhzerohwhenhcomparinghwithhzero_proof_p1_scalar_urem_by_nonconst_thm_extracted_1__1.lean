
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p1_scalar_urem_by_nonconst_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ||| 6#32 = 0 → ofBool ((x_1 &&& 128#32) % (x ||| 6#32) == 0#32) = ofBool (x_1 &&& 128#32 == 0#32) :=
sorry