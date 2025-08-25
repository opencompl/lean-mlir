
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

theorem sdiv_shl_pair_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x <<< 2#32).sshiftRight' 2#32 ≠ x ∨
        2#32 ≥ ↑32 ∨
          True ∧ (x <<< 1#32).sshiftRight' 1#32 ≠ x ∨
            1#32 ≥ ↑32 ∨ (x <<< 1#32 == 0 || 32 != 1 && x <<< 2#32 == intMin 32 && x <<< 1#32 == -1) = true) →
    (x <<< 2#32).sdiv (x <<< 1#32) = 2#32 :=
sorry