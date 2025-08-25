
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem smear_set_bit_different_dest_type_wider_dst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (signExtend 64 ((truncate 8 x).sshiftRight' 7#8))) PoisonOr.poison :=
sorry