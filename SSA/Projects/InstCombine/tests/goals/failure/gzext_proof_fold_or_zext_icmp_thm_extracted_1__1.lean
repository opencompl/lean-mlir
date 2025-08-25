
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_or_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  zeroExtend 8 (ofBool (x_1 <ₛ x_2)) ||| zeroExtend 8 (ofBool (x_2 <ₛ x)) =
    zeroExtend 8 (ofBool (x_1 <ₛ x_2) ||| ofBool (x_2 <ₛ x)) :=
sorry