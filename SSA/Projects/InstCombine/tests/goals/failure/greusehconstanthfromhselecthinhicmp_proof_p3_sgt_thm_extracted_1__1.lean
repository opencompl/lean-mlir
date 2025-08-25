
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p3_sgt_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (65534#32 <ₛ x) = 1#1 → ¬ofBool (x <ₛ 65535#32) = 1#1 → False :=
sorry