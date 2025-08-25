
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

theorem narrow_zext_ashr_keep_trunc3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    ¬(True ∧ (zeroExtend 14 x_1).saddOverflow (zeroExtend 14 x) = true ∨
          True ∧ (zeroExtend 14 x_1).uaddOverflow (zeroExtend 14 x) = true ∨ 1#14 ≥ ↑14) →
      truncate 7 ((signExtend 64 x_1 + signExtend 64 x).sshiftRight' 1#64) =
        truncate 7 ((zeroExtend 14 x_1 + zeroExtend 14 x) >>> 1#14) :=
sorry