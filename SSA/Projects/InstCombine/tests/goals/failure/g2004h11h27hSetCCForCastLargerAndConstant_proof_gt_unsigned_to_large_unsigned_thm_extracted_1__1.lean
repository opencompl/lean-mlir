
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem gt_unsigned_to_large_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (1024#32 <ᵤ zeroExtend 32 x) = 0#1 :=
sorry