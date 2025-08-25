
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

theorem test_invert_demorgan_logical_or_thm.extracted_1._5 : ∀ (x x_1 : BitVec 64),
  ¬ofBool (x_1 == 27#64) = 1#1 →
    ofBool (x_1 != 27#64) = 1#1 →
      (ofBool (x_1 == 0#64) ||| ofBool (x == 0#64)) ^^^ 1#1 = ofBool (x_1 != 0#64) &&& ofBool (x != 0#64) :=
sorry