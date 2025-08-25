
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowmask_add_zext_wrong_mask_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 8),
  zeroExtend 32 x_1 + x &&& 511#32 = x + zeroExtend 32 x_1 &&& 511#32 :=
sorry