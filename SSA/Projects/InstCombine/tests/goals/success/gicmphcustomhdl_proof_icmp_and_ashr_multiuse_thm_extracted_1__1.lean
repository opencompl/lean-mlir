
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

theorem icmp_and_ashr_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    ofBool (x.sshiftRight' 4#32 &&& 15#32 != 14#32) &&& ofBool (x.sshiftRight' 4#32 &&& 31#32 != 27#32) =
      ofBool (x &&& 240#32 != 224#32) &&& ofBool (x &&& 496#32 != 432#32) :=
sorry