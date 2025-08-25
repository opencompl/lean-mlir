
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_aggressive_icmp_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 128#32) = 1#1 → ofBool (x + 256#32 <ᵤ 512#32) = ofBool (x <ᵤ 128#32) :=
sorry