
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

theorem ashr_shl_constants_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ 3#32 ≥ ↑32) →
    x ≥ ↑32 ∨
        True ∧
            ((BitVec.ofInt 32 (-33)).sshiftRight' x <<< 3#32).sshiftRight' 3#32 ≠
              (BitVec.ofInt 32 (-33)).sshiftRight' x ∨
          3#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((BitVec.ofInt 32 (-33)).sshiftRight' x <<< 3#32)) PoisonOr.poison :=
sorry