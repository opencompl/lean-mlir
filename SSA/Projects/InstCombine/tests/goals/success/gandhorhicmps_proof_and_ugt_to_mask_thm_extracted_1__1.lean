
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

theorem and_ugt_to_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (BitVec.ofInt 8 (-5) <ᵤ x) &&& ofBool (x &&& 2#8 == 0#8) =
    ofBool (x &&& BitVec.ofInt 8 (-2) == BitVec.ofInt 8 (-4)) :=
sorry