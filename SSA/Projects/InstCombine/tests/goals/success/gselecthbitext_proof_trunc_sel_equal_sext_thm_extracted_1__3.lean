
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

theorem trunc_sel_equal_sext_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ x <<< 16#32 >>> 16#32 <<< 16#32 ≠ x <<< 16#32 ∨ 16#32 ≥ ↑32) →
      signExtend 32 (truncate 16 x) = (x <<< 16#32).sshiftRight' 16#32 :=
sorry