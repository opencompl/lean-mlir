
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test86_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬4#32 ≥ ↑32 →
    4#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 ((signExtend 32 x).sshiftRight' 4#32))) PoisonOr.poison :=
sorry