
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

theorem test_shl_nuw__all_are_safe_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 15#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 15#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1 <<< 2#32 &&& 60#32)) :=
sorry