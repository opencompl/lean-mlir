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

theorem main_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    5#8 ≥ ↑8 ∨ True ∧ ((truncate 8 x ^^^ -1#8) <<< 5#8 &&& 64#8).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (zeroExtend 32
            (((truncate 8 x ||| BitVec.ofInt 8 (-17)) ^^^
                  ((truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)) <<< 6#8 ^^^
                    (truncate 8 x &&& 122#8 ^^^ BitVec.ofInt 8 (-17)))) >>>
                7#8 *
              64#8)))
        PoisonOr.poison :=
sorry