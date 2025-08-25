
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

theorem lshr_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬((42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 5#64 ≥ ↑64 ∨ 7#64 ≥ ↑64) →
    12#64 ≥ ↑64 ∨ (42#64 == 0 || 64 != 1 && x_1 == intMin 64 && 42#64 == -1) = true ∨ 7#64 ≥ ↑64 → False :=
sorry