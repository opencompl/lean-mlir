
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_lshr_icmp_bad_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 1#32) = 1#1 →
    ¬x_1 ≥ ↑32 →
      1#32 ≥ ↑32 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x >>> x_1)) PoisonOr.poison :=
sorry