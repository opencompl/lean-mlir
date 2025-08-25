
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test92_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬32#96 ≥ ↑96 →
    32#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 64 (signExtend 96 x >>> 32#96))) PoisonOr.poison :=
sorry