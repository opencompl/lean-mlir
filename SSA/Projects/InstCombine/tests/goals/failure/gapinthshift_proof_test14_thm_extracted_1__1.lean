
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test14_thm.extracted_1._1 : ∀ (x : BitVec 35),
  ¬(4#35 ≥ ↑35 ∨ 4#35 ≥ ↑35) →
    True ∧ (x &&& BitVec.ofInt 35 (-19760) &&& 19744#35 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 35)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x >>> 4#35 ||| 1234#35) <<< 4#35)) PoisonOr.poison :=
sorry