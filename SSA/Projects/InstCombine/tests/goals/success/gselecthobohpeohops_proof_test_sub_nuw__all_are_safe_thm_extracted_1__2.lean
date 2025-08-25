
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

theorem test_sub_nuw__all_are_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 255#32 == 6#32) = 1#1 →
    ¬(True ∧ (BitVec.ofInt 32 (-254)).ssubOverflow (x &&& 255#32) = true ∨
          True ∧ (BitVec.ofInt 32 (-254)).usubOverflow (x &&& 255#32) = true) →
      BitVec.ofInt 32 (-260) = BitVec.ofInt 32 (-254) - (x &&& 255#32) :=
sorry