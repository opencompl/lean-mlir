
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

theorem multiuse_lshr_lshr_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬(2#9 ≥ ↑9 ∨ 2#9 ≥ ↑9 ∨ 3#9 ≥ ↑9) →
    2#9 ≥ ↑9 ∨ 5#9 ≥ ↑9 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 9)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x >>> 2#9 * x >>> 2#9 >>> 3#9)) PoisonOr.poison :=
sorry