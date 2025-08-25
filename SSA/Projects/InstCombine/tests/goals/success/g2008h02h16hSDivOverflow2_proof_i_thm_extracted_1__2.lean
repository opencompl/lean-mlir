
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

theorem i_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬((BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-3) == -1) = true ∨
        (BitVec.ofInt 8 (-3) == 0 || 8 != 1 && x.sdiv (BitVec.ofInt 8 (-3)) == intMin 8 && BitVec.ofInt 8 (-3) == -1) =
          true) →
    ¬(9#8 == 0 || 8 != 1 && x == intMin 8 && 9#8 == -1) = true →
      (x.sdiv (BitVec.ofInt 8 (-3))).sdiv (BitVec.ofInt 8 (-3)) = x.sdiv 9#8 :=
sorry