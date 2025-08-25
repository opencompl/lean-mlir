
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

theorem test51_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    ¬(True ∧ (truncate 32 x &&& BitVec.ofInt 32 (-2) &&& zeroExtend 32 (x_1 ^^^ 1#1) != 0) = true) →
      signExtend 64 (truncate 32 x ||| 1#32) =
        signExtend 64 (truncate 32 x &&& BitVec.ofInt 32 (-2) ||| zeroExtend 32 (x_1 ^^^ 1#1)) :=
sorry