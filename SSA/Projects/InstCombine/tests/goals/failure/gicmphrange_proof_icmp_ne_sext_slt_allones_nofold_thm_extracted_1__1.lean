
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_ne_sext_slt_allones_nofold_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (signExtend 32 (ofBool (x <ₛ -1#32)) != x) = ofBool (x != signExtend 32 (ofBool (x <ₛ -1#32))) :=
sorry