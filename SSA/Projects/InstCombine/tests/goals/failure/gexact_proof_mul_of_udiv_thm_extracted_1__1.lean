
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_of_udiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.umod 12#8 ≠ 0 ∨ 12#8 = 0) →
    True ∧ x >>> 1#8 <<< 1#8 ≠ x ∨ 1#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x / 12#8 * 6#8)) PoisonOr.poison :=
sorry