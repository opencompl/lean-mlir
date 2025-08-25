
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n10_wrong_low_bit_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 31#8 == 0#8) = 1#1 → x + 16#8 &&& BitVec.ofInt 8 (-16) = (x &&& BitVec.ofInt 8 (-16)) + 16#8 :=
sorry