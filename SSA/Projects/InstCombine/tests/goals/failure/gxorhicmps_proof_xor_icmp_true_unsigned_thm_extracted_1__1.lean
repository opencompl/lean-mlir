
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_icmp_true_unsigned_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (5#32 <ᵤ x) ^^^ ofBool (x <ᵤ 6#32) = 1#1 :=
sorry