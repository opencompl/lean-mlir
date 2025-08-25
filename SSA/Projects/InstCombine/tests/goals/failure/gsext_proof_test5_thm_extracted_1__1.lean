
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬30000#32 = 0 →
    30000#32 = 0 ∨ True ∧ (x % 30000#32).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (signExtend 64 (x % 30000#32))) PoisonOr.poison :=
sorry