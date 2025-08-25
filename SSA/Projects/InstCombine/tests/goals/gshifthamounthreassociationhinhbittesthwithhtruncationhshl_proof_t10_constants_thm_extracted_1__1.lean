
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

theorem t10_constants_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 14#64 ≥ ↑64) →
    26#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (x_1 >>> 12#32 &&& truncate 32 (x <<< 14#64) != 0#32))) PoisonOr.poison :=
sorry