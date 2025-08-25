
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem demorgan_or_zext_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  zeroExtend 32 x_1 ^^^ 1#32 ||| zeroExtend 32 x ^^^ 1#32 = zeroExtend 32 (x_1 &&& x ^^^ 1#1) :=
sorry