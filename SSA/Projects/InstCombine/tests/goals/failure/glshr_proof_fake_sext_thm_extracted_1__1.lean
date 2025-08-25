
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fake_sext_thm.extracted_1._1 : ∀ (x : BitVec 3),
  ¬17#18 ≥ ↑18 →
    2#3 ≥ ↑3 ∨ True ∧ (x >>> 2#3).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 18)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (signExtend 18 x >>> 17#18)) PoisonOr.poison :=
sorry