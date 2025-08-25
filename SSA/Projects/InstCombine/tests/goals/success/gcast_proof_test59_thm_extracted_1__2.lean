
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

theorem test59_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    ¬(True ∧ (zeroExtend 32 x <<< 4#32).sshiftRight' 4#32 ≠ zeroExtend 32 x ∨
          True ∧ zeroExtend 32 x <<< 4#32 >>> 4#32 ≠ zeroExtend 32 x ∨
            4#32 ≥ ↑32 ∨
              4#8 ≥ ↑8 ∨
                True ∧ (x_1 >>> 4#8).msb = true ∨
                  True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 &&& zeroExtend 32 (x_1 >>> 4#8) != 0) = true ∨
                    True ∧ (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)).msb = true) →
      zeroExtend 64 (zeroExtend 32 x_1 >>> 4#32 ||| zeroExtend 32 x <<< 4#32 &&& 48#32) =
        zeroExtend 64 (zeroExtend 32 x <<< 4#32 &&& 48#32 ||| zeroExtend 32 (x_1 >>> 4#8)) :=
sorry