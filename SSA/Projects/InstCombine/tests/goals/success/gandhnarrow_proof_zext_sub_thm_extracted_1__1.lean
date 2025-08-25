
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sub_thm.extracted_1._1 : ∀ (x : BitVec 8),
  BitVec.ofInt 16 (-5) - zeroExtend 16 x &&& zeroExtend 16 x = zeroExtend 16 (BitVec.ofInt 8 (-5) - x &&& x) :=
sorry