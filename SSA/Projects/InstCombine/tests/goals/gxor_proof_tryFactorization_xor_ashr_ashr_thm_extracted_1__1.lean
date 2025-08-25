
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

theorem tryFactorization_xor_ashr_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) →
    x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((BitVec.ofInt 32 (-3)).sshiftRight' x ^^^ (BitVec.ofInt 32 (-5)).sshiftRight' x))
        PoisonOr.poison :=
sorry