
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

theorem shl_add_nuw_and_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x &&& 2#8 ≥ ↑8 →
    True ∧ ((x_1 &&& 31#8) <<< (x &&& 2#8)).sshiftRight' (x &&& 2#8) ≠ x_1 &&& 31#8 ∨
        True ∧ (x_1 &&& 31#8) <<< (x &&& 2#8) >>> (x &&& 2#8) ≠ x_1 &&& 31#8 ∨ x &&& 2#8 ≥ ↑8 →
      False :=
sorry