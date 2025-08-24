
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

theorem fake_sext_thm.extracted_1._1 : ∀ (x : BitVec 3),
  ¬17#18 ≥ ↑18 →
    2#3 ≥ ↑3 ∨ True ∧ (x >>> 2#3).msb = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 18)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (signExtend 18 x >>> 17#18)) PoisonOr.poison :=
sorry