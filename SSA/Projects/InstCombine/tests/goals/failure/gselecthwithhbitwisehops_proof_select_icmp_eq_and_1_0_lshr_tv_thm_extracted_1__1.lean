
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_eq_and_1_0_lshr_tv_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 &&& 1#8 != 0#8) = 1#1 →
    ¬2#8 ≥ ↑8 →
      1#8 ≥ ↑8 ∨ x_1 <<< 1#8 &&& 2#8 ≥ ↑8 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x >>> 2#8)) PoisonOr.poison :=
sorry