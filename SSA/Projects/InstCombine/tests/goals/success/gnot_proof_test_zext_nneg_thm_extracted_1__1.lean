
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

theorem test_zext_nneg_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32) (x_2 : BitVec 64),
  ¬(True ∧ (x_1 ^^^ -1#32).msb = true) →
    x_2 + BitVec.ofInt 64 (-5) - (zeroExtend 64 (x_1 ^^^ -1#32) + x) =
      x_2 + BitVec.ofInt 64 (-4) + (signExtend 64 x_1 - x) :=
sorry