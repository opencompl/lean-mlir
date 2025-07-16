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

theorem shl1_trunc_sgt4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (4#16 <ₛ truncate 16 (1#32 <<< x)))) PoisonOr.poison :=
sorry