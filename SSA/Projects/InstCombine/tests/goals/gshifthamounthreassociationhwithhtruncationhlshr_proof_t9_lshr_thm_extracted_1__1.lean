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

theorem t9_lshr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16) →
    True ∧ (32#16 - x).msb = true ∨ zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-2) ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 16 (x_1 >>> zeroExtend 32 (32#16 - x)) >>> (x + BitVec.ofInt 16 (-2))))
        PoisonOr.poison :=
sorry