
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 49),
  ¬(17#49 ≥ ↑49 ∨ 4096#49 <<< 17#49 = 0) →
    29#49 ≥ ↑49 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 49)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x / 4096#49 <<< 17#49)) PoisonOr.poison :=
sorry