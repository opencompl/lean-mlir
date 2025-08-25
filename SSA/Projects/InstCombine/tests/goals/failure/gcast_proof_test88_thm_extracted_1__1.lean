
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test88_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬18#32 ≥ ↑32 →
    15#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 ((signExtend 32 x).sshiftRight' 18#32))) PoisonOr.poison :=
sorry