
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_diff_i1_xor_sub_thm.extracted_1._2 : ∀ (x x_1 : BitVec 1),
  ¬(True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true) →
    signExtend 64 x_1 - signExtend 64 x = zeroExtend 64 x + signExtend 64 x_1 :=
sorry