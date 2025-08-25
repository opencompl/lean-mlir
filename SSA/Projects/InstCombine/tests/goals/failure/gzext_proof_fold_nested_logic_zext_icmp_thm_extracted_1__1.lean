
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_nested_logic_zext_icmp_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 64),
  zeroExtend 8 (ofBool (x_2 <ₛ x_3)) &&& zeroExtend 8 (ofBool (x_3 <ₛ x_1)) ||| zeroExtend 8 (ofBool (x_3 == x)) =
    zeroExtend 8 (ofBool (x_2 <ₛ x_3) &&& ofBool (x_3 <ₛ x_1) ||| ofBool (x_3 == x)) :=
sorry