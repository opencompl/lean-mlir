
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

theorem t10_constants_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 14#64 ≥ ↑64) →
    ¬26#32 ≥ ↑32 →
      ofBool (x_1 >>> 12#32 &&& truncate 32 (x <<< 14#64) != 0#32) = ofBool (x_1 >>> 26#32 &&& truncate 32 x != 0#32) :=
sorry