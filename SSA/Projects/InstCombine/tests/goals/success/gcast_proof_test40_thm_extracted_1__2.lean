
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

theorem test40_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(9#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    ¬(9#16 ≥ ↑16 ∨ 8#16 ≥ ↑16 ∨ True ∧ (x >>> 9#16 &&& x <<< 8#16 != 0) = true) →
      truncate 16 (zeroExtend 32 x >>> 9#32 ||| zeroExtend 32 x <<< 8#32) = x >>> 9#16 ||| x <<< 8#16 :=
sorry