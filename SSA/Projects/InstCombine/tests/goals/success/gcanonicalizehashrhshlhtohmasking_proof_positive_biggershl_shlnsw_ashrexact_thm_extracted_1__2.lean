
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

theorem positive_biggershl_shlnsw_ashrexact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨
        3#8 ≥ ↑8 ∨ True ∧ (x.sshiftRight' 3#8 <<< 6#8).sshiftRight' 6#8 ≠ x.sshiftRight' 3#8 ∨ 6#8 ≥ ↑8) →
    ¬(True ∧ (x <<< 3#8).sshiftRight' 3#8 ≠ x ∨ 3#8 ≥ ↑8) → x.sshiftRight' 3#8 <<< 6#8 = x <<< 3#8 :=
sorry