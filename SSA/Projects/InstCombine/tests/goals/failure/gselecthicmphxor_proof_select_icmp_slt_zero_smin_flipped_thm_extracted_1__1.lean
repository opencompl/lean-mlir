
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_slt_zero_smin_flipped_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x <ₛ 0#8) = 1#1 → x ^^^ BitVec.ofInt 8 (-128) = x &&& 127#8 :=
sorry