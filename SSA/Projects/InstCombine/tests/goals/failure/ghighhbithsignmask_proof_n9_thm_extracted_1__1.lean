
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n9_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬62#64 ≥ ↑64 →
    62#64 ≥ ↑64 ∨ True ∧ (0#64).ssubOverflow (x >>> 62#64) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#64 - x >>> 62#64)) PoisonOr.poison :=
sorry