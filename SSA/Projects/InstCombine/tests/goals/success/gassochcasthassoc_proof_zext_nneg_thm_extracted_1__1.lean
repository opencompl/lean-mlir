
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ (x &&& 32767#16).msb = true) →
    zeroExtend 24 (x &&& 32767#16) &&& 8388607#24 = zeroExtend 24 (x &&& 32767#16) :=
sorry