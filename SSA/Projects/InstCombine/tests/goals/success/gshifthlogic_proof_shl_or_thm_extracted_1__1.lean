
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

theorem shl_or_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬((42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨ 5#16 ≥ ↑16 ∨ 7#16 ≥ ↑16) →
    12#16 ≥ ↑16 ∨
        (42#16 == 0 || 16 != 1 && x_1 == intMin 16 && 42#16 == -1) = true ∨
          True ∧ (x_1.srem 42#16 <<< 7#16).sshiftRight' 7#16 ≠ x_1.srem 42#16 ∨ 7#16 ≥ ↑16 →
      False :=
sorry