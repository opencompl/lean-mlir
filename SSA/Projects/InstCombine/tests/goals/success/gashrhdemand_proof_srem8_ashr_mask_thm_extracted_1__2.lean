
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

theorem srem8_ashr_mask_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬((8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    ¬ofBool (BitVec.ofInt 32 (-2147483648) <ᵤ x &&& BitVec.ofInt 32 (-2147483641)) = 1#1 →
      (x.srem 8#32).sshiftRight' 31#32 &&& 2#32 = 0#32 :=
sorry