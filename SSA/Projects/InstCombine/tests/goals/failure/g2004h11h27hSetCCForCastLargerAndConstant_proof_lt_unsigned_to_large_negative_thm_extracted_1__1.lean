
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lt_unsigned_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (zeroExtend 32 x <ₛ BitVec.ofInt 32 (-1024)) = 0#1 :=
sorry