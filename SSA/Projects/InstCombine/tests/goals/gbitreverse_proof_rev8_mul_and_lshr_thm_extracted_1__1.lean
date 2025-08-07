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

theorem rev8_mul_and_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (zeroExtend 64 x).smulOverflow 2050#64 = true ∨
        True ∧ (zeroExtend 64 x).umulOverflow 2050#64 = true ∨
          True ∧ (zeroExtend 64 x).smulOverflow 32800#64 = true ∨
            True ∧ (zeroExtend 64 x).umulOverflow 32800#64 = true ∨
              True ∧
                  (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).smulOverflow
                      65793#64 =
                    true ∨
                True ∧
                    (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).umulOverflow
                        65793#64 =
                      true ∨
                  16#64 ≥ ↑64) →
    True ∧ (zeroExtend 64 x).smulOverflow 2050#64 = true ∨
        True ∧ (zeroExtend 64 x).umulOverflow 2050#64 = true ∨
          True ∧ (zeroExtend 64 x).smulOverflow 32800#64 = true ∨
            True ∧ (zeroExtend 64 x).umulOverflow 32800#64 = true ∨
              True ∧
                  (zeroExtend 64 x * 2050#64 &&& 139536#64 &&& (zeroExtend 64 x * 32800#64 &&& 558144#64) != 0) = true ∨
                True ∧
                    (zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64).smulOverflow
                        65793#64 =
                      true ∨
                  True ∧
                      (zeroExtend 64 x * 2050#64 &&& 139536#64 |||
                              zeroExtend 64 x * 32800#64 &&& 558144#64).umulOverflow
                          65793#64 =
                        true ∨
                    16#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value
          (truncate 8
            (((zeroExtend 64 x * 2050#64 &&& 139536#64 ||| zeroExtend 64 x * 32800#64 &&& 558144#64) * 65793#64) >>>
              16#64)))
        PoisonOr.poison :=
sorry