
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_and_8_eq_0_xor_8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 8#32 == 0#32) = 1#1 → x ^^^ 8#32 = x ||| 8#32 :=
sorry