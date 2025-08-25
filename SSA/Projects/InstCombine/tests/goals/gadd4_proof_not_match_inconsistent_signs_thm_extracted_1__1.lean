
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

theorem not_match_inconsistent_signs_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(299#64 = 0 ∨ (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨ 64#64 = 0) →
    299#64 = 0 ∨
        (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
          True ∧ (x.sdiv 299#64 &&& 63#64).smulOverflow 299#64 = true ∨
            True ∧ (x.sdiv 299#64 &&& 63#64).umulOverflow 299#64 = true ∨
              True ∧ (x % 299#64).saddOverflow ((x.sdiv 299#64 &&& 63#64) * 299#64) = true ∨
                True ∧ (x % 299#64).uaddOverflow ((x.sdiv 299#64 &&& 63#64) * 299#64) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x % 299#64 + x.sdiv 299#64 % 64#64 * 299#64)) PoisonOr.poison :=
sorry