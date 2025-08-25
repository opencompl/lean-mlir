
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_icmp_invalid_range_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x == 0#8) ^^^ ofBool (x != 4#8) = ofBool (x &&& BitVec.ofInt 8 (-5) != 0#8) :=
sorry