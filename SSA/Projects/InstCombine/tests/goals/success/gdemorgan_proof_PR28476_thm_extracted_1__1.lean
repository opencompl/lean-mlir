
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR28476_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  zeroExtend 32 (ofBool (x_1 != 0#32) &&& ofBool (x != 0#32)) ^^^ 1#32 =
    zeroExtend 32 (ofBool (x_1 == 0#32) ||| ofBool (x == 0#32)) :=
sorry