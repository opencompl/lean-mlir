
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

theorem addhshlhsdivhnegative0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬((4#8 == 0 || 8 != 1 && x == intMin 8 && 4#8 == -1) = true ∨ 2#8 ≥ ↑8) →
    (4#8 == 0 || 8 != 1 && x == intMin 8 && 4#8 == -1) = true ∨
        True ∧ (x.sdiv 4#8 <<< 2#8).sshiftRight' 2#8 ≠ x.sdiv 4#8 ∨ 2#8 ≥ ↑8 →
      False :=
sorry