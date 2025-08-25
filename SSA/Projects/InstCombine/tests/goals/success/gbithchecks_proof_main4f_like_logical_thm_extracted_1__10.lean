
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

theorem main4f_like_logical_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 →
    ofBool (x_2 &&& x_1 == x_1) = 1#1 →
      ¬ofBool (x_2 &&& x != x) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x == x)) :=
sorry