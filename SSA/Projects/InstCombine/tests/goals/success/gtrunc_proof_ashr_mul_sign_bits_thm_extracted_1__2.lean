
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

theorem ashr_mul_sign_bits_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬3#32 ≥ ↑32 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 3#16 ≥ ↑16) →
      truncate 16 ((signExtend 32 x_1 * signExtend 32 x).sshiftRight' 3#32) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 3#16 :=
sorry