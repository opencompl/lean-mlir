
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

theorem xor_add_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (73#32).ssubOverflow (x &&& 31#32) = true ∨ True ∧ (73#32).usubOverflow (x &&& 31#32) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @instHRefinementOfRefinement _
        (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
      (PoisonOr.value ((x &&& 31#32 ^^^ 31#32) + 42#32)) PoisonOr.poison :=
sorry