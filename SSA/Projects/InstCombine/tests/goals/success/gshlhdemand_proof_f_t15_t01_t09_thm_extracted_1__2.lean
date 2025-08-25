
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

theorem f_t15_t01_t09_thm.extracted_1._2 : ∀ (x : BitVec 40),
  ¬(31#40 ≥ ↑40 ∨ 16#32 ≥ ↑32) →
    ¬(15#40 ≥ ↑40 ∨ True ∧ signExtend 40 (truncate 32 (x.sshiftRight' 15#40)) ≠ x.sshiftRight' 15#40) →
      truncate 32 (x.sshiftRight' 31#40) <<< 16#32 = truncate 32 (x.sshiftRight' 15#40) &&& BitVec.ofInt 32 (-65536) :=
sorry