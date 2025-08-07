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

theorem test59_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    True ∧ (zeroExtend 32 x <<< 4#32).sshiftRight' 4#32 ≠ zeroExtend 32 x ∨
        True ∧ zeroExtend 32 x <<< 4#32 >>> 4#32 ≠ zeroExtend 32 x ∨
          4#32 ≥ ↑32 ∨
            4#8 ≥ ↑8 ∨
              True ∧ (x_1 >>> 4#8).msb = true ∨
                True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 &&& zeroExtend 32 (x_1 >>> 4#8) != 0) = true ∨
                  True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (zeroExtend 64 (zeroExtend 32 x_1 >>> 4#32 ||| zeroExtend 32 x <<< 4#32 &&& 48#32)))
        PoisonOr.poison :=
sorry