
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    1#32 ≥ ↑32 ∨ True ∧ (8#32).ssubOverflow (x.sshiftRight' 1#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (8#64 - signExtend 64 (x.sshiftRight' 1#32))) PoisonOr.poison :=
sorry