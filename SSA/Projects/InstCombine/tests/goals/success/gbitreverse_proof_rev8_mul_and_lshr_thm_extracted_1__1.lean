
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)

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