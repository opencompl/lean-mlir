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

theorem test48_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬8#32 ≥ ↑32 →
    True ∧ (zeroExtend 32 x <<< 8#32).sshiftRight' 8#32 ≠ zeroExtend 32 x ∨
        True ∧ zeroExtend 32 x <<< 8#32 >>> 8#32 ≠ zeroExtend 32 x ∨
          8#32 ≥ ↑32 ∨
            True ∧ (zeroExtend 32 x <<< 8#32 &&& zeroExtend 32 x != 0) = true ∨
              True ∧ (zeroExtend 32 x <<< 8#32 ||| zeroExtend 32 x).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (zeroExtend 64 (zeroExtend 32 x <<< 8#32 ||| zeroExtend 32 x))) PoisonOr.poison :=
sorry