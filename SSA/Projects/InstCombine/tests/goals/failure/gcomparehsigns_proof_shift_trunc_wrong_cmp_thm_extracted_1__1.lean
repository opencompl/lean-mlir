
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_trunc_wrong_cmp_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 →
    24#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 8 (x >>> 24#32)) ≠ x >>> 24#32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (truncate 8 (x >>> 24#32) <ₛ 1#8))) PoisonOr.poison :=
sorry