
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

theorem testi32i8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#8 ≥ ↑8 ∨ 8#32 ≥ ↑32) →
    ¬ofBool ((truncate 8 x).sshiftRight' 7#8 == truncate 8 (x >>> 8#32)) = 1#1 →
      ¬15#32 ≥ ↑32 → truncate 8 (x.sshiftRight' 15#32) ^^^ 127#8 = truncate 8 (x >>> 15#32) ^^^ 127#8 :=
sorry