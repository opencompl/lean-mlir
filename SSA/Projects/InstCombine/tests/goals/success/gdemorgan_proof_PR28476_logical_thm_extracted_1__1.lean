
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR28476_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x != 0#32) = 1#1 → ofBool (x == 0#32) = 1#1 → zeroExtend 32 0#1 ^^^ 1#32 = zeroExtend 32 1#1 :=
sorry