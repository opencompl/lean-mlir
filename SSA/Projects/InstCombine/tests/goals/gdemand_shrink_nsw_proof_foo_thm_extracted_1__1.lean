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

theorem foo_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 223#32 ^^^ 29#32).uaddOverflow (BitVec.ofInt 32 (-784568073)) = true ∨
        True ∧
            (((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                      ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                    1#32).sshiftRight'
                1#32 ≠
              (x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^ ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32) ∨
          True ∧
              ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                      ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                    1#32 >>>
                  1#32 ≠
                (x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^ ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32) ∨
            1#32 ≥ ↑32 ∨
              True ∧
                ((x &&& 223#32 ^^^ 29#32) + BitVec.ofInt 32 (-784568073) -
                        ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                            ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                          1#32).saddOverflow
                    1533579450#32 =
                  true) →
    True ∧ (x &&& 223#32 ^^^ 29#32).saddOverflow 1362915575#32 = true ∨
        True ∧ (x &&& 223#32 ^^^ 29#32).uaddOverflow 1362915575#32 = true ∨
          True ∧ ((x &&& 223#32 ^^^ 29#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 223#32 ^^^ 29#32 ∨
            True ∧ (x &&& 223#32 ^^^ 29#32) <<< 1#32 >>> 1#32 ≠ x &&& 223#32 ^^^ 29#32 ∨
              1#32 ≥ ↑32 ∨
                True ∧
                    ((x &&& 223#32 ^^^ 29#32) + 1362915575#32).ssubOverflow
                        ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32) =
                      true ∨
                  True ∧
                      ((x &&& 223#32 ^^^ 29#32) + 1362915575#32).usubOverflow
                          ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32) =
                        true ∨
                    True ∧
                      ((x &&& 223#32 ^^^ 29#32) + 1362915575#32 -
                              ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32)).uaddOverflow
                          1533579450#32 =
                        true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (((x &&& 223#32 ^^^ 29#32) + BitVec.ofInt 32 (-784568073) -
                  ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                      ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                    1#32 +
                1533579450#32 |||
              BitVec.ofInt 32 (-2147483648)) ^^^
            749011377#32))
        PoisonOr.poison :=
sorry