
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_zext_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬6#32 ≥ ↑32 →
    6#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (zeroExtend 32 x >>> 6#32))) PoisonOr.poison :=
sorry