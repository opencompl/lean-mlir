
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

theorem multiuse2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((x &&& 96#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 96#32 ∨
        True ∧ (x &&& 96#32) <<< 8#32 >>> 8#32 ≠ x &&& 96#32 ∨
          8#32 ≥ ↑32 ∨
            True ∧ ((x &&& 6#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 6#32 ∨
              True ∧ (x &&& 6#32) <<< 8#32 >>> 8#32 ≠ x &&& 6#32 ∨
                8#32 ≥ ↑32 ∨
                  True ∧ ((x &&& 24#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 24#32 ∨
                    True ∧ (x &&& 24#32) <<< 8#32 >>> 8#32 ≠ x &&& 24#32 ∨
                      8#32 ≥ ↑32 ∨
                        True ∧ ((x &&& 6#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 6#32 ∨
                          True ∧ (x &&& 6#32) <<< 1#32 >>> 1#32 ≠ x &&& 6#32 ∨
                            1#32 ≥ ↑32 ∨
                              True ∧ ((x &&& 96#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 96#32 ∨
                                True ∧ (x &&& 96#32) <<< 1#32 >>> 1#32 ≠ x &&& 96#32 ∨
                                  1#32 ≥ ↑32 ∨
                                    True ∧ ((x &&& 24#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 24#32 ∨
                                      True ∧ (x &&& 24#32) <<< 1#32 >>> 1#32 ≠ x &&& 24#32 ∨ 1#32 ≥ ↑32) →
    8#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          1#32 ≥ ↑32 ∨
            1#32 ≥ ↑32 ∨
              True ∧ (x <<< 1#32 &&& 192#32 &&& (x <<< 1#32 &&& 48#32) != 0) = true ∨
                True ∧ (x <<< 1#32 &&& 12#32 &&& (x <<< 1#32 &&& 192#32 ||| x <<< 1#32 &&& 48#32) != 0) = true ∨
                  True ∧
                    (x <<< 8#32 &&& 32256#32 &&&
                          (x <<< 1#32 &&& 12#32 ||| (x <<< 1#32 &&& 192#32 ||| x <<< 1#32 &&& 48#32)) !=
                        0) =
                      true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          ((x &&& 96#32) <<< 8#32 ||| ((x &&& 6#32) <<< 8#32 ||| (x &&& 24#32) <<< 8#32) |||
            ((x &&& 6#32) <<< 1#32 ||| ((x &&& 96#32) <<< 1#32 ||| (x &&& 24#32) <<< 1#32))))
        PoisonOr.poison :=
sorry