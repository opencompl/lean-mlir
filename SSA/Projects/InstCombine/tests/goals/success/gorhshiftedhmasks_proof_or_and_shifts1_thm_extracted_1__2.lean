
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

theorem or_and_shifts1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    ¬(3#32 ≥ ↑32 ∨ 5#32 ≥ ↑32 ∨ True ∧ (x <<< 3#32 &&& 8#32 &&& (x <<< 5#32 &&& 32#32) != 0) = true) →
      x <<< 3#32 &&& 15#32 ||| x <<< 5#32 &&& 60#32 = x <<< 3#32 &&& 8#32 ||| x <<< 5#32 &&& 32#32 :=
sorry