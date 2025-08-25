
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

theorem fast_div_201_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(8#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ 1#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
          True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
            8#16 ≥ ↑16 ∨
              True ∧
                  signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠ (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                True ∧
                    zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                      (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                  1#8 ≥ ↑8 ∨
                    True ∧ (zeroExtend 16 x).smulOverflow 71#16 = true ∨
                      True ∧ (zeroExtend 16 x).umulOverflow 71#16 = true ∨
                        8#16 ≥ ↑16 ∨
                          True ∧
                              signExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                            True ∧
                                zeroExtend 16 (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) ≠
                                  (zeroExtend 16 x * 71#16) >>> 8#16 ∨
                              True ∧
                                  ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8).uaddOverflow
                                      (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) =
                                    true ∨
                                7#8 ≥ ↑8) →
      (truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16) +
            (x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8) >>>
          7#8 =
        ((x - truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>> 1#8 +
            truncate 8 ((zeroExtend 16 x * 71#16) >>> 8#16)) >>>
          7#8 :=
sorry