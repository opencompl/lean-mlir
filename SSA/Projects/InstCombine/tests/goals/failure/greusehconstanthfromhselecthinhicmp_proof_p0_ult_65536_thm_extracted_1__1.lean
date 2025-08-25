
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_ult_65536_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ 65536#32) = 1#1 → ¬ofBool (65535#32 <ᵤ x) = 1#1 → False :=
sorry