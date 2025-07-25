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

theorem test91_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬48#96 ≥ ↑96 →
    48#96 ≥ ↑96 ∨
        True ∧ signExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 ∨
          True ∧ zeroExtend 96 (truncate 64 (signExtend 96 x >>> 48#96)) ≠ signExtend 96 x >>> 48#96 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 64 (signExtend 96 x >>> 48#96))) PoisonOr.poison :=
sorry