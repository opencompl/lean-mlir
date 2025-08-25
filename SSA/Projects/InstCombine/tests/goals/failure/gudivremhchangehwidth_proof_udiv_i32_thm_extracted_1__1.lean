
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬zeroExtend 32 x = 0 →
    x = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 x_1 / zeroExtend 32 x)) PoisonOr.poison :=
sorry