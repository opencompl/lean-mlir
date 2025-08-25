
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

theorem test11_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨
          True ∧
              (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
                zeroExtend 64 x_1 ∨
            True ∧
                zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
              zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 (zeroExtend 128 x_1 <<< (zeroExtend 128 x &&& 31#128)) =
        zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) :=
sorry