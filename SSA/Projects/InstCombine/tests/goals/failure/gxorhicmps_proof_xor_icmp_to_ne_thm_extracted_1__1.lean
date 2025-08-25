
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_icmp_to_ne_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (4#32 <ₛ x) ^^^ ofBool (x <ₛ 6#32) = ofBool (x != 5#32) :=
sorry