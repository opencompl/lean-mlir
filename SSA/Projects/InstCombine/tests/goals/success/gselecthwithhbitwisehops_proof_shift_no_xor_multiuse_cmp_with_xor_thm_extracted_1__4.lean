
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

theorem shift_no_xor_multiuse_cmp_with_xor_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& 1#32 == 0#32) = 1#1 →
    ¬(True ∧ ((x_2 &&& 1#32) <<< 1#32).sshiftRight' 1#32 ≠ x_2 &&& 1#32 ∨
          True ∧ (x_2 &&& 1#32) <<< 1#32 >>> 1#32 ≠ x_2 &&& 1#32 ∨ 1#32 ≥ ↑32) →
      (x_1 ^^^ 2#32) * x = (x_1 ^^^ (x_2 &&& 1#32) <<< 1#32) * x :=
sorry