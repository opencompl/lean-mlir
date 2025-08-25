
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR2844_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x == 0#32) ||| ofBool (x <ₛ BitVec.ofInt 32 (-638208501)) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x != 0#32) &&& ofBool (BitVec.ofInt 32 (-638208502) <ₛ x)) :=
sorry