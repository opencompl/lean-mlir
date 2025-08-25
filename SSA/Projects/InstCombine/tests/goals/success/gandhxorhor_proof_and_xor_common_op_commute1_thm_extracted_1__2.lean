
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

theorem and_xor_common_op_commute1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x_1 = 0 ∨ x = 0 ∨ x_1 = 0) →
    ¬(x_1 = 0 ∨ x = 0) → 42#32 / x_1 &&& (43#32 / x ^^^ 42#32 / x_1) = 42#32 / x_1 &&& (43#32 / x ^^^ -1#32) :=
sorry