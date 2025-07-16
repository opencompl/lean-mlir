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

theorem shl_mask_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 →
    True ∧ ((x &&& 255#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 255#32 ∨
        True ∧ (x &&& 255#32) <<< 8#32 >>> 8#32 ≠ x &&& 255#32 ∨
          8#32 ≥ ↑32 ∨ True ∧ (x &&& 255#32 &&& (x &&& 255#32) <<< 8#32 != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x &&& 255#32 ||| (x &&& 255#32) <<< 8#32)) PoisonOr.poison :=
sorry