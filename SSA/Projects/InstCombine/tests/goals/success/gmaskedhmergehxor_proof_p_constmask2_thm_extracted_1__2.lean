
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

theorem p_constmask2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& 61440#32 &&& (x &&& BitVec.ofInt 32 (-65281)) != 0) = true) →
    x_1 &&& 61440#32 ^^^ x &&& BitVec.ofInt 32 (-65281) = x_1 &&& 61440#32 ||| x &&& BitVec.ofInt 32 (-65281) :=
sorry