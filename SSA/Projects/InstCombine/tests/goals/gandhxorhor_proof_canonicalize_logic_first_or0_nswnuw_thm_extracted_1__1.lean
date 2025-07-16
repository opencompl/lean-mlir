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

theorem canonicalize_logic_first_or0_nswnuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow 112#32 = true ∨ True ∧ x.uaddOverflow 112#32 = true) →
    True ∧ (x ||| 15#32).saddOverflow 112#32 = true ∨ True ∧ (x ||| 15#32).uaddOverflow 112#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x + 112#32 ||| 15#32)) PoisonOr.poison :=
sorry