
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

theorem masked_bit_clear_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬((x_1 == 0 || 32 != 1 && 42#32 == intMin 32 && x_1 == -1) = true ∨ x ≥ ↑32) →
    zeroExtend 32 (ofBool ((42#32).srem x_1 &&& 1#32 <<< x == 0#32)) = ((42#32).srem x_1 ^^^ -1#32) >>> x &&& 1#32 :=
sorry