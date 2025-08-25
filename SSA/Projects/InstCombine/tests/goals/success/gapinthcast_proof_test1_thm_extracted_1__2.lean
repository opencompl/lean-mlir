
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

theorem test1_thm.extracted_1._2 : ∀ (x : BitVec 17),
  ¬(8#37 ≥ ↑37 ∨ 8#37 ≥ ↑37) →
    ¬(8#17 ≥ ↑17 ∨ 8#17 ≥ ↑17) →
      truncate 17 (zeroExtend 37 x >>> 8#37 ||| zeroExtend 37 x <<< 8#37) = x >>> 8#17 ||| x <<< 8#17 :=
sorry