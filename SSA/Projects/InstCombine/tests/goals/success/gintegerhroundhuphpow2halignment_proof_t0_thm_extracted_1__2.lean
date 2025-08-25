
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 15#8 == 0#8) = 1#1 → x + 16#8 &&& BitVec.ofInt 8 (-16) = x + 15#8 &&& BitVec.ofInt 8 (-16) :=
sorry