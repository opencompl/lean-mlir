
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_zext_64_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬7#8 ≥ ↑8 →
    7#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 64 (truncate 8 x <<< 7#8))) PoisonOr.poison :=
sorry