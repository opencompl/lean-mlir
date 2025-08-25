
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

theorem sdiv_icmp5_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smod (BitVec.ofInt 64 (-5)) ≠ 0 ∨
        (BitVec.ofInt 64 (-5) == 0 || 64 != 1 && x == intMin 64 && BitVec.ofInt 64 (-5) == -1) = true) →
    ofBool (x.sdiv (BitVec.ofInt 64 (-5)) == 1#64) = ofBool (x == BitVec.ofInt 64 (-5)) :=
sorry