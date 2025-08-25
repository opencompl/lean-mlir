
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

theorem trunc_sandwich_max_sum_shift2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(30#32 ≥ ↑32 ∨ 1#12 ≥ ↑12) →
    ¬(31#32 ≥ ↑32 ∨
          True ∧ signExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32 ∨
            True ∧ zeroExtend 32 (truncate 12 (x >>> 31#32)) ≠ x >>> 31#32) →
      truncate 12 (x >>> 30#32) >>> 1#12 = truncate 12 (x >>> 31#32) :=
sorry