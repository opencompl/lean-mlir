
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lowbitmask_casted_shift_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 →
    1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (signExtend 32 (x.sshiftRight' 1#8) &&& 2147483647#32)) PoisonOr.poison :=
sorry