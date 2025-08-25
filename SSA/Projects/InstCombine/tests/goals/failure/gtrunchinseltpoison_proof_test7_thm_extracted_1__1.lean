
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬32#128 ≥ ↑128 →
    32#64 ≥ ↑64 ∨ True ∧ (x >>> 32#64).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 92)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 92 (zeroExtend 128 x >>> 32#128))) PoisonOr.poison :=
sorry