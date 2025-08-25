
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 →
    4#8 ≥ ↑8 ∨ True ∧ (x >>> 4#8 &&& x).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 16 x >>> 4#16 &&& zeroExtend 16 x)) PoisonOr.poison :=
sorry