
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n11_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16) →
    True ∧ (30#16 - x).msb = true ∨ zeroExtend 32 (30#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-31) ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 (x_1 <<< zeroExtend 32 (30#16 - x)) <<< (x + BitVec.ofInt 16 (-31))))
        PoisonOr.poison :=
sorry