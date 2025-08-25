
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

theorem test_invert_demorgan_or3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  (ofBool (x_1 == 178206#32) ||| ofBool (x + BitVec.ofInt 32 (-195102) <ᵤ 1506#32) |||
          ofBool (x + BitVec.ofInt 32 (-201547) <ᵤ 716213#32) |||
        ofBool (x + BitVec.ofInt 32 (-918000) <ᵤ 196112#32)) ^^^
      1#1 =
    ofBool (x_1 != 178206#32) &&& ofBool (x + BitVec.ofInt 32 (-196608) <ᵤ BitVec.ofInt 32 (-1506)) &&&
        ofBool (x + BitVec.ofInt 32 (-917760) <ᵤ BitVec.ofInt 32 (-716213)) &&&
      ofBool (x + BitVec.ofInt 32 (-1114112) <ᵤ BitVec.ofInt 32 (-196112)) :=
sorry