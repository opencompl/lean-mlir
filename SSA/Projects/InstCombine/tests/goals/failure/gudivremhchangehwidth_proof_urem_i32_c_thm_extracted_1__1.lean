
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_i32_c_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬10#32 = 0 →
    10#8 = 0 ∨ True ∧ (x % 10#8).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 x % 10#32)) PoisonOr.poison :=
sorry