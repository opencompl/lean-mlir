
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_icmp_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 512#32) &&& ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x <ᵤ 128#32) :=
sorry