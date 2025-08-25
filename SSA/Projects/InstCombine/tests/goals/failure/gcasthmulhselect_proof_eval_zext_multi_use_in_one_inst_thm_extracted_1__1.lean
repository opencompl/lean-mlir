
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eval_zext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 5#16).smulOverflow (truncate 16 x &&& 5#16) = true ∨
        True ∧ (truncate 16 x &&& 5#16).umulOverflow (truncate 16 x &&& 5#16) = true) →
    True ∧ (truncate 16 x &&& 5#16).smulOverflow (truncate 16 x &&& 5#16) = true ∨
        True ∧ (truncate 16 x &&& 5#16).umulOverflow (truncate 16 x &&& 5#16) = true ∨
          True ∧ ((truncate 16 x &&& 5#16) * (truncate 16 x &&& 5#16)).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 ((truncate 16 x &&& 5#16) * (truncate 16 x &&& 5#16)))) PoisonOr.poison :=
sorry