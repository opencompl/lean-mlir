
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_xor_icmp_bad_6_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != 1#32) = 1#1 →
    ofBool (x_1 == 1#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value x) PoisonOr.poison :=
sorry