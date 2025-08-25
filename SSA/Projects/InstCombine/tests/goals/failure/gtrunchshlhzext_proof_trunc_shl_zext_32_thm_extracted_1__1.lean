
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_zext_32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬4#16 ≥ ↑16 →
    4#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 (truncate 16 x <<< 4#16))) PoisonOr.poison :=
sorry