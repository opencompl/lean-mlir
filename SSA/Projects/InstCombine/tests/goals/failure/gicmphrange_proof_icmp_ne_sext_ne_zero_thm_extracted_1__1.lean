
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_sext_ne_zero_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x != 0#32)) != x) = ofBool (x + -1#32 <ᵤ BitVec.ofInt 32 (-2)) :=
sorry