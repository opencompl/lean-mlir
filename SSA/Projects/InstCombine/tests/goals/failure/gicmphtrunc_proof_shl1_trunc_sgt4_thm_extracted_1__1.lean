
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl1_trunc_sgt4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (4#16 <ₛ truncate 16 (1#32 <<< x)))) PoisonOr.poison :=
sorry