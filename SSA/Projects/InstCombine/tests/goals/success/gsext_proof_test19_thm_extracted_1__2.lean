
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

theorem test19_thm.extracted_1._2 : ∀ (x : BitVec 10),
  ¬(2#3 ≥ ↑3 ∨ 2#3 ≥ ↑3) →
    ¬(True ∧ (0#3).ssubOverflow (truncate 3 x &&& 1#3) = true) →
      signExtend 10 ((truncate 3 x <<< 2#3).sshiftRight' 2#3) = signExtend 10 (0#3 - (truncate 3 x &&& 1#3)) :=
sorry