
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

theorem test_invert_demorgan_or2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  (ofBool (23#64 <ᵤ x_2) ||| ofBool (59#64 <ᵤ x_1) ||| ofBool (59#64 <ᵤ x)) ^^^ 1#1 =
    ofBool (x_2 <ᵤ 24#64) &&& ofBool (x_1 <ᵤ 60#64) &&& ofBool (x <ᵤ 60#64) :=
sorry