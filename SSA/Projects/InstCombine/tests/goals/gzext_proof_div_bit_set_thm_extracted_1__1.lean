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

theorem div_bit_set_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 ≥ ↑32 ∨ (x == 0 || 32 != 1 && 1#32 <<< x_1 == intMin 32 && x == -1) = true) →
    True ∧ 1#32 <<< x_1 >>> x_1 ≠ 1#32 ∨
        x_1 ≥ ↑32 ∨ (x == 0 || 32 != 1 && 1#32 <<< x_1 == intMin 32 && x == -1) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (zeroExtend 32 (ofBool ((1#32 <<< x_1).sdiv x != 0#32)))) PoisonOr.poison :=
sorry