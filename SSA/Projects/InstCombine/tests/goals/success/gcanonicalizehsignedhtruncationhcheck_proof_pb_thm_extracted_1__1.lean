
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

theorem pb_thm.extracted_1._1 : ∀ (x : BitVec 65),
  ¬(1#65 ≥ ↑65 ∨ True ∧ x <<< 1#65 >>> 1#65 <<< 1#65 ≠ x <<< 1#65 ∨ 1#65 ≥ ↑65) →
    ofBool (x != (x <<< 1#65).sshiftRight' 1#65) = ofBool (x + 9223372036854775808#65 <ₛ 0#65) :=
sorry