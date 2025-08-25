
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_trunc_not_arg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x_1) &&& ofBool (x + 128#32 <ᵤ 256#32) =
    ofBool (x_1 &&& 128#32 == 0#32) &&& ofBool (x + 128#32 <ᵤ 256#32) :=
sorry