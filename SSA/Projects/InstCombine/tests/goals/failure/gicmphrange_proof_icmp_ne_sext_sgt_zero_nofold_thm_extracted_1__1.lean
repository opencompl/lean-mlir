
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_sext_sgt_zero_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (0#32 <ₛ x)) != x) = ofBool (x != signExtend 32 (ofBool (0#32 <ₛ x))) :=
sorry