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

theorem shift_xor_multiuse_cmp_with_and_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (0#32 != x_2 &&& 4096#32) = 1#1 →
    ¬ofBool (x_2 &&& 4096#32 == 0#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value ((x_1 &&& BitVec.ofInt 32 (-2049)) * x)) PoisonOr.poison :=
sorry