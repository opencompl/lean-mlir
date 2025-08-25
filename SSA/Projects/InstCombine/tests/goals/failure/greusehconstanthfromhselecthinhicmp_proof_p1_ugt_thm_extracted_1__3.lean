
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p1_ugt_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (65534#32 <ᵤ x_1) = 1#1 → ¬ofBool (x_1 <ᵤ 65535#32) = 1#1 → 65535#32 = x :=
sorry