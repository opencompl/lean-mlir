
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_xor_zext_commute_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  (x_1 * x_1 ^^^ zeroExtend 32 x) &&& 255#32 = zeroExtend 32 (x ^^^ truncate 8 (x_1 * x_1)) :=
sorry