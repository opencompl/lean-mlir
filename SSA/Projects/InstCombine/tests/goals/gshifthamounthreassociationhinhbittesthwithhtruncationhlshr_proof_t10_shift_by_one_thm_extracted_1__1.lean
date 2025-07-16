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

theorem t10_shift_by_one_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 x_2 : BitVec 32),
  ¬(64#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-63)) ≥ ↑64) →
    64#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-63)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-63)) ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (ofBool (x_2 <<< (64#32 - x_1) &&& truncate 32 (x >>> zeroExtend 64 (x_1 + BitVec.ofInt 32 (-63))) != 0#32)))
        PoisonOr.poison :=
sorry