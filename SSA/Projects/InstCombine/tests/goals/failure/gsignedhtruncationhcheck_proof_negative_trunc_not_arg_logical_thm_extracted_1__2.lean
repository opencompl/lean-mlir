
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_trunc_not_arg_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#8 <ₛ truncate 8 x_1) = 1#1 →
    ¬ofBool (x_1 &&& 128#32 == 0#32) = 1#1 → ofBool (x + 128#32 <ᵤ 256#32) = 0#1 :=
sorry