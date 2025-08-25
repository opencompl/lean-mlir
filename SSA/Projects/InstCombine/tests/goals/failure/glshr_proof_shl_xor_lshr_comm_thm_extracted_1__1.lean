
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_xor_lshr_comm_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑32 ∨ x ≥ ↑32) →
    x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x_2 ^^^ x_1 <<< x) >>> x)) PoisonOr.poison :=
sorry