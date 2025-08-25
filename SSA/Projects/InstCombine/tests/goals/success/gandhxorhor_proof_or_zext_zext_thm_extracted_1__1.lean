
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_zext_zext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 4),
  zeroExtend 16 x_1 ||| zeroExtend 16 x = zeroExtend 16 (x ||| zeroExtend 8 x_1) :=
sorry