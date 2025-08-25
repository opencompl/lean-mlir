
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

theorem multiuse3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 96#32) >>> 1#32 <<< 1#32 ≠ x &&& 96#32 ∨
        1#32 ≥ ↑32 ∨
          1#32 ≥ ↑32 ∨
            True ∧ ((x &&& 96#32) <<< 6#32).sshiftRight' 6#32 ≠ x &&& 96#32 ∨
              True ∧ (x &&& 96#32) <<< 6#32 >>> 6#32 ≠ x &&& 96#32 ∨ 6#32 ≥ ↑32 ∨ 6#32 ≥ ↑32) →
    1#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          True ∧ (x >>> 1#32 &&& 48#32 &&& (x >>> 1#32 &&& 15#32) != 0) = true ∨
            6#32 ≥ ↑32 ∨
              True ∧ ((x >>> 1#32 &&& 48#32 ||| x >>> 1#32 &&& 15#32) &&& (x <<< 6#32 &&& 8064#32) != 0) = true →
      False :=
sorry