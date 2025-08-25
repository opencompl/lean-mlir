
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_shl_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#16 ≥ ↑16 →
    3#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 16 x <<< 3#16 &&& zeroExtend 16 x)) PoisonOr.poison :=
sorry