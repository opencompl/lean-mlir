
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_true_implies_b_true2_comm_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬ofBool (10#8 <ᵤ x_1) = 1#1 →
    ofBool (20#8 <ᵤ x_1) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x &&& ofBool (20#8 <ᵤ x_1))) PoisonOr.poison :=
sorry