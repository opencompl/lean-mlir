
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

theorem ashr_mul_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬8#20 ≥ ↑20 →
    ¬(True ∧ (signExtend 16 x_1).smulOverflow (signExtend 16 x) = true ∨ 8#16 ≥ ↑16) →
      truncate 16 ((signExtend 20 x_1 * signExtend 20 x).sshiftRight' 8#20) =
        (signExtend 16 x_1 * signExtend 16 x).sshiftRight' 8#16 :=
sorry