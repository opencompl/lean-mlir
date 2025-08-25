
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_eq_pow2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x &&& 4#8 == 0#8) = 1#1 → x = x &&& BitVec.ofInt 8 (-5) :=
sorry