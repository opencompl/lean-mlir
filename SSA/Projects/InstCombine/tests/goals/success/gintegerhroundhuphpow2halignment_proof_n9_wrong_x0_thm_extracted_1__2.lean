
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n9_wrong_x0_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 15#8 == 0#8) = 1#1 → x_1 + 16#8 &&& BitVec.ofInt 8 (-16) = (x_1 &&& BitVec.ofInt 8 (-16)) + 16#8 :=
sorry