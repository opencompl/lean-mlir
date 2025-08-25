
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

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
      False :=
sorry