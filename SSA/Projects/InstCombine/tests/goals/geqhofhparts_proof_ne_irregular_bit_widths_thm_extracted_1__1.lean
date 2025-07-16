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

theorem ne_irregular_bit_widths_thm.extracted_1._1 : ∀ (x x_1 : BitVec 31),
  ¬(13#31 ≥ ↑31 ∨ 13#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31) →
    7#31 ≥ ↑31 ∨ 7#31 ≥ ↑31 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (ofBool (truncate 5 (x_1 >>> 13#31) != truncate 5 (x >>> 13#31)) |||
            ofBool (truncate 6 (x_1 >>> 7#31) != truncate 6 (x >>> 7#31))))
        PoisonOr.poison :=
sorry