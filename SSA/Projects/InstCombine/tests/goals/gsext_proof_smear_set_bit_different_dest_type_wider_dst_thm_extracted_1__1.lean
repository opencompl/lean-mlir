
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem smear_set_bit_different_dest_type_wider_dst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (signExtend 64 ((truncate 8 x).sshiftRight' 7#8))) PoisonOr.poison :=
sorry