
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5c_like_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 7#32) = 1#1 →
    ofBool (x &&& 7#32 == 7#32) = 1#1 →
      True →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 0#32) PoisonOr.poison :=
sorry