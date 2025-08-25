
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t2_const_lshr_shl_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(1#32 ≥ ↑32 ∨ 1#32 ≥ ↑32) →
    2#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (x_1 <<< 1#32 &&& x >>> 1#32 == 0#32))) PoisonOr.poison :=
sorry