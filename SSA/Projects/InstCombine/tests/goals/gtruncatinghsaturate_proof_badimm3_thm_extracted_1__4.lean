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

theorem badimm3_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(7#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬14#16 ≥ ↑16 →
        ¬ofBool (x + 128#16 <ᵤ 256#16) = 1#1 →
          14#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 14#16)) ≠ x.sshiftRight' 14#16 →
            HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
              @instHRefinementOfRefinement _
                (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
              (PoisonOr.value (truncate 8 (x.sshiftRight' 14#16) ^^^ 127#8)) PoisonOr.poison :=
sorry