
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

theorem test16_thm.extracted_1._2 : ∀ (x : BitVec 51),
  ¬(1123#51 == 0 || 51 != 1 && x == intMin 51 && 1123#51 == -1) = true →
    ¬(BitVec.ofInt 51 (-1123) == 0 || 51 != 1 && x == intMin 51 && BitVec.ofInt 51 (-1123) == -1) = true →
      0#51 - x.sdiv 1123#51 = x.sdiv (BitVec.ofInt 51 (-1123)) :=
sorry