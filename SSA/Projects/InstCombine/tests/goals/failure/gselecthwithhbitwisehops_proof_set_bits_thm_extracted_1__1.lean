
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem set_bits_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  x_1 = 1#1 →
    True ∧ (x &&& BitVec.ofInt 8 (-6) &&& 5#8 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x ||| 5#8)) PoisonOr.poison :=
sorry