
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

theorem ashr_exact_add_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 1#32 = true ∨
        True ∧ BitVec.ofInt 32 (-4) >>> (x + 1#32) <<< (x + 1#32) ≠ BitVec.ofInt 32 (-4) ∨ x + 1#32 ≥ ↑32) →
    ¬(True ∧ BitVec.ofInt 32 (-2) >>> x <<< x ≠ BitVec.ofInt 32 (-2) ∨ x ≥ ↑32) →
      (BitVec.ofInt 32 (-4)).sshiftRight' (x + 1#32) = (BitVec.ofInt 32 (-2)).sshiftRight' x :=
sorry