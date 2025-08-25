
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_inverted_icmp_preds_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ x) = 1#1 →
    ¬ofBool (x ≤ₛ x_1) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#32 ||| 0#32)) PoisonOr.poison :=
sorry