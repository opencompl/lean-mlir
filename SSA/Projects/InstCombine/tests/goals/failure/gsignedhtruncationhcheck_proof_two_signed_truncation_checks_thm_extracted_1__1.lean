
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem two_signed_truncation_checks_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x + 512#32 <ᵤ 1024#32) &&& ofBool (x + 128#32 <ᵤ 256#32) = ofBool (x + 128#32 <ᵤ 256#32) :=
sorry