
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_trunc_base_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#16 <ₛ truncate 16 x) &&& ofBool (truncate 16 x + 128#16 <ᵤ 256#16) = ofBool (x &&& 65408#32 == 0#32) :=
sorry