
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

theorem is_ascii_alphabetic_inverted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-91)) = true) →
    ofBool (x + BitVec.ofInt 32 (-91) <ᵤ BitVec.ofInt 32 (-26)) = 1#1 →
      ¬(True ∧ x.saddOverflow (BitVec.ofInt 32 (-123)) = true) →
        ofBool (x + BitVec.ofInt 32 (-123) <ᵤ BitVec.ofInt 32 (-26)) =
          ofBool ((x &&& BitVec.ofInt 32 (-33)) + BitVec.ofInt 32 (-91) <ᵤ BitVec.ofInt 32 (-26)) :=
sorry