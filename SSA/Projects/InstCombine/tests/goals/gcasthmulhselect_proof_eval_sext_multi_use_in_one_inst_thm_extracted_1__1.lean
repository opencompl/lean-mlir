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

theorem eval_sext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true) →
    True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true ∨
          True ∧ ((truncate 16 x &&& 14#16) * (truncate 16 x &&& 14#16) &&& BitVec.ofInt 16 (-32768) != 0) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (signExtend 32 ((truncate 16 x &&& 14#16) * (truncate 16 x &&& 14#16) ||| BitVec.ofInt 16 (-32768))))
        PoisonOr.poison :=
sorry