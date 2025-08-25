
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR28476_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x != 0#32) = 1#1 →
    ¬ofBool (x == 0#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 0#1 ^^^ 1#32)) PoisonOr.poison :=
sorry