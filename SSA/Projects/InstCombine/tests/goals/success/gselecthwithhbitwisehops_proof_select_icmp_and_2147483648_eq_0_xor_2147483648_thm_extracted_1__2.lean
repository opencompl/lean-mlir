
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_and_2147483648_eq_0_xor_2147483648_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& BitVec.ofInt 32 (-2147483648) == 0#32) = 1#1 → x = x ||| BitVec.ofInt 32 (-2147483648) :=
sorry