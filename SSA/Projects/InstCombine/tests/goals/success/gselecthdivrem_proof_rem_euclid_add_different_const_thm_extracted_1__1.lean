
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

theorem rem_euclid_add_different_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true →
    ofBool (x.srem 8#32 <ₛ 0#32) = 1#1 →
      (8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true ∨ True ∧ (x.srem 8#32).saddOverflow 9#32 = true →
        False :=
sorry