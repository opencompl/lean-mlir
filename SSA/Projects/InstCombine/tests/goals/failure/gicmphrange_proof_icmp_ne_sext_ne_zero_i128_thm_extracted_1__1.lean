
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_sext_ne_zero_i128_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ofBool (signExtend 128 (ofBool (x != 0#128)) != x) = ofBool (x + -1#128 <ᵤ BitVec.ofInt 128 (-2)) :=
sorry