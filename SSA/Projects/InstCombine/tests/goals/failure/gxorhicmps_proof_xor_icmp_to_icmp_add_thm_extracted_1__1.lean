
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_icmp_to_icmp_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (3#32 <ₛ x) ^^^ ofBool (x <ₛ 6#32) = ofBool (x + BitVec.ofInt 32 (-6) <ᵤ BitVec.ofInt 32 (-2)) :=
sorry