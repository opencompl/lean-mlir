
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

theorem zext_ashr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬2#16 ≥ ↑16 →
    ¬(2#8 ≥ ↑8 ∨ True ∧ (x >>> 2#8 &&& x).msb = true) →
      (zeroExtend 16 x).sshiftRight' 2#16 &&& zeroExtend 16 x = zeroExtend 16 (x >>> 2#8 &&& x) :=
sorry