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

theorem shl1_trunc_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬x ≥ ↑9 →
    True ∧ 1#9 <<< x >>> x ≠ 1#9 ∨ x ≥ ↑9 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (0#6 <ₛ truncate 6 (1#9 <<< x)))) PoisonOr.poison :=
sorry