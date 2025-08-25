
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

theorem canonicalize_logic_first_and0_nsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 48#8 = true) →
    ¬(True ∧ (x &&& BitVec.ofInt 8 (-10)).saddOverflow 48#8 = true) →
      x + 48#8 &&& BitVec.ofInt 8 (-10) = (x &&& BitVec.ofInt 8 (-10)) + 48#8 :=
sorry