
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

theorem a_false_implies_b_true2_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬ofBool (x_1 <ᵤ 20#8) = 1#1 →
    ¬ofBool (10#8 <ᵤ x_1) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (ofBool (10#8 <ᵤ x_1) ||| x)) PoisonOr.poison :=
sorry