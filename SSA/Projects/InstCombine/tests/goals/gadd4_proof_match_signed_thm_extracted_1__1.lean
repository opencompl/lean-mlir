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

theorem match_signed_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬((299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
        (299#64 == 0 || 64 != 1 && x == intMin 64 && 299#64 == -1) = true ∨
          (64#64 == 0 || 64 != 1 && x.sdiv 299#64 == intMin 64 && 64#64 == -1) = true ∨
            (19136#64 == 0 || 64 != 1 && x == intMin 64 && 19136#64 == -1) = true ∨
              (9#64 == 0 || 64 != 1 && x.sdiv 19136#64 == intMin 64 && 9#64 == -1) = true) →
    (172224#64 == 0 || 64 != 1 && x == intMin 64 && 172224#64 == -1) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x.srem 299#64 + (x.sdiv 299#64).srem 64#64 * 299#64 + (x.sdiv 19136#64).srem 9#64 * 19136#64))
        PoisonOr.poison :=
sorry