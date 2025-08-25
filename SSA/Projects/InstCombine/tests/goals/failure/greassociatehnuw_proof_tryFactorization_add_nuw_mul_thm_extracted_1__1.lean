
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_add_nuw_mul_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 3#32 = true) →
    2#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x * 3#32 + x)) PoisonOr.poison :=
sorry