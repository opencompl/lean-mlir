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

theorem ashr_pow2_ult_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 →
    True ∧ BitVec.ofInt 8 (-128) >>> x <<< x ≠ BitVec.ofInt 8 (-128) ∨ x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool ((BitVec.ofInt 8 (-128)).sshiftRight' x <ᵤ BitVec.ofInt 8 (-96)))) PoisonOr.poison :=
sorry