
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n12_wrong_bias_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 15#8 == 0#8) = 1#1 → x + 32#8 &&& BitVec.ofInt 8 (-16) = (x &&& BitVec.ofInt 8 (-16)) + 32#8 :=
sorry