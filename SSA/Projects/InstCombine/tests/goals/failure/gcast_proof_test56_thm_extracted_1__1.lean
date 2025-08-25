
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test56_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬5#32 ≥ ↑32 →
    5#32 ≥ ↑32 ∨ True ∧ (signExtend 32 x >>> 5#32).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 64 (signExtend 32 x >>> 5#32))) PoisonOr.poison :=
sorry