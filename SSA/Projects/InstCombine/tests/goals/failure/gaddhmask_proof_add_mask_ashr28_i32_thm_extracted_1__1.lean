
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_mask_ashr28_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32) →
    28#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x.sshiftRight' 28#32 &&& 8#32) + x.sshiftRight' 28#32)) PoisonOr.poison :=
sorry