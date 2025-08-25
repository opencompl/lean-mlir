
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem canonicalize_logic_first_xor_0_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 96#8 = true) →
    True ∧ (x ^^^ 31#8).saddOverflow 96#8 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x + 96#8 ^^^ 31#8)) PoisonOr.poison :=
sorry