
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem gt_signed_to_large_negative_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 32 (-1024) <ₛ signExtend 32 x) = 1#1 :=
sorry