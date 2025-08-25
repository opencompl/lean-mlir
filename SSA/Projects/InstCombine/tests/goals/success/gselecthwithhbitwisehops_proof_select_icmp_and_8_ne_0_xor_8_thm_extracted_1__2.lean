
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_and_8_ne_0_xor_8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 8#32 == 0#32) = 1#1 → x ^^^ 8#32 = x &&& BitVec.ofInt 32 (-9) :=
sorry