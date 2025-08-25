
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_diff_i1_xor_sub_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 1),
  True ∧ (zeroExtend 64 x).saddOverflow (signExtend 64 x_1) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 64 x_1 - signExtend 64 x)) PoisonOr.poison :=
sorry