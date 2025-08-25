
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬30#32 ≥ ↑32 →
    30#32 ≥ ↑32 ∨ True ∧ (x &&& 128#32 &&& x >>> 30#32 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x &&& 128#32) + x >>> 30#32)) PoisonOr.poison :=
sorry