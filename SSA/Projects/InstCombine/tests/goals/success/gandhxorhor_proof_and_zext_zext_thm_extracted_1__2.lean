
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_zext_thm.extracted_1._2 : ∀ (x : BitVec 4) (x_1 : BitVec 8),
  ¬(True ∧ (x_1 &&& zeroExtend 8 x).msb = true) →
    zeroExtend 16 x_1 &&& zeroExtend 16 x = zeroExtend 16 (x_1 &&& zeroExtend 8 x) :=
sorry