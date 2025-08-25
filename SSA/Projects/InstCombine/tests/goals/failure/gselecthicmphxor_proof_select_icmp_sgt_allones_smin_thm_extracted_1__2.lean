
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_sgt_allones_smin_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (-1#8 <ₛ x) = 1#1 → x ^^^ BitVec.ofInt 8 (-128) = x &&& 127#8 :=
sorry