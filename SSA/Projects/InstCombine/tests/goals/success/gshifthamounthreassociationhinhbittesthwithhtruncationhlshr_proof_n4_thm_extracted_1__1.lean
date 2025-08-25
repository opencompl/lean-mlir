
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

theorem n4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(32#32 - x ≥ ↑32 ∨ zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x ≥ ↑32 ∨
        True ∧ (x + BitVec.ofInt 32 (-16)).msb = true ∨
          zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ≥ ↑64 ∨
            True ∧
                signExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) ∨
              True ∧
                zeroExtend 64 (truncate 32 (262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)))) ≠
                  262143#64 >>> zeroExtend 64 (x + BitVec.ofInt 32 (-16)) →
      False :=
sorry