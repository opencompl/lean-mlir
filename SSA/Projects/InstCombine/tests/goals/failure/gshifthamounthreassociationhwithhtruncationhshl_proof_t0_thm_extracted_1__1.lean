
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-24) ≥ ↑16) →
    8#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 (x_1 <<< zeroExtend 32 (32#16 - x)) <<< (x + BitVec.ofInt 16 (-24))))
        PoisonOr.poison :=
sorry