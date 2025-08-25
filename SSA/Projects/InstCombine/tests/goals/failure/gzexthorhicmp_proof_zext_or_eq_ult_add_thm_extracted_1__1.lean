
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_or_eq_ult_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32) ||| ofBool (x == 5#32)) =
    zeroExtend 32 (ofBool (x + BitVec.ofInt 32 (-3) <ᵤ 3#32)) :=
sorry