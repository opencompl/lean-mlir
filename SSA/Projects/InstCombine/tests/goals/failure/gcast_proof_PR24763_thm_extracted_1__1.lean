
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR24763_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#32 ≥ ↑32 →
    1#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 (signExtend 32 x >>> 1#32))) PoisonOr.poison :=
sorry