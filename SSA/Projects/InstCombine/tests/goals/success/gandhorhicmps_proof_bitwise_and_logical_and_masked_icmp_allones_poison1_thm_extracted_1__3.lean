
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

theorem bitwise_and_logical_and_masked_icmp_allones_poison1_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ofBool (x_2 &&& (x_1 ||| 7#32) == x_1 ||| 7#32) = 1#1 → x &&& ofBool (x_2 &&& 7#32 == 7#32) = x :=
sorry