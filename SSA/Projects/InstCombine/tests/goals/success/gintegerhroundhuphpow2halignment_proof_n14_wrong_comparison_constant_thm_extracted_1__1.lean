
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n14_wrong_comparison_constant_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 15#8 == 1#8) = 1#1 → x + 16#8 &&& BitVec.ofInt 8 (-16) = (x &&& BitVec.ofInt 8 (-16)) + 16#8 :=
sorry