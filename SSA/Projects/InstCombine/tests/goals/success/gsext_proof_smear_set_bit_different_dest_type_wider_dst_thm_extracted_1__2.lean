
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

theorem smear_set_bit_different_dest_type_wider_dst_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
      signExtend 64 ((truncate 8 x).sshiftRight' 7#8) = signExtend 64 ((x <<< 24#32).sshiftRight' 31#32) :=
sorry