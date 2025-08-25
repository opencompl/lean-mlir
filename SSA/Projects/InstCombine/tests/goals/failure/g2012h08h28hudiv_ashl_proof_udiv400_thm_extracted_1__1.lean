
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv400_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 100#32 = 0) →
    400#32 = 0 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x >>> 2#32 / 100#32)) PoisonOr.poison :=
sorry