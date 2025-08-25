
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_shl_mask_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬x ≥ ↑32 → signExtend 32 x_1 <<< x &&& 65535#32 = zeroExtend 32 x_1 <<< x &&& 65535#32 :=
sorry