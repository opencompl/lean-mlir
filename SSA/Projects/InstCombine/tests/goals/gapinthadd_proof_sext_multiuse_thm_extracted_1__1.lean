
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

theorem sext_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true ∨
        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == 0 ||
              7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 &&
                zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 &&
                  truncate 4
                      ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8))) ==
                    intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
    (signExtend 7 x == 0 || 7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 && signExtend 7 x == -1) =
          true ∨
        (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
            4 != 1 && truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x)) == intMin 4 &&
              x ^^^ BitVec.ofInt 4 (-8) == -1) =
          true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 4)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          ((truncate 4
                ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                  (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8)))).sdiv
            (x ^^^ BitVec.ofInt 4 (-8))))
        PoisonOr.poison :=
sorry