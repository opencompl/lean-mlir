
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

theorem lshr_mul_negative_nsw_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smulOverflow 52#64 = true ∨ 2#64 ≥ ↑64) →
    True ∧ x.smulOverflow 52#64 = true ∨ True ∧ (x * 52#64) >>> 2#64 <<< 2#64 ≠ x * 52#64 ∨ 2#64 ≥ ↑64 → False :=
sorry