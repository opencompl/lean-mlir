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

theorem multiuse1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 2#32) >>> 1#32 <<< 1#32 ≠ x &&& 2#32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x &&& 4#32) >>> 1#32 <<< 1#32 ≠ x &&& 4#32 ∨
            1#32 ≥ ↑32 ∨
              True ∧ ((x &&& 2#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 2#32 ∨
                True ∧ (x &&& 2#32) <<< 6#32 >>> 6#32 ≠ x &&& 2#32 ∨
                  6#32 ≥ ↑32 ∨
                    True ∧ ((x &&& 4#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 4#32 ∨
                      True ∧ (x &&& 4#32) <<< 6#32 >>> 6#32 ≠ x &&& 4#32 ∨ 6#32 ≥ ↑32) →
    1#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x >>> 1#32 &&& 1#32 &&& (x >>> 1#32 &&& 2#32) != 0) = true ∨
            6#32 ≥ ↑32 ∨
              True ∧ ((x >>> 1#32 &&& 1#32 ||| x >>> 1#32 &&& 2#32) &&& (x <<< 6#32 &&& 384#32) != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          ((x &&& 2#32) >>> 1#32 ||| (x &&& 4#32) >>> 1#32 ||| ((x &&& 2#32) <<< 6#32 ||| (x &&& 4#32) <<< 6#32)))
        PoisonOr.poison :=
sorry