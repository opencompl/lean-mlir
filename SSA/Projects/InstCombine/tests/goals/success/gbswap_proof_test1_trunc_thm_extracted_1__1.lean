
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

theorem test1_trunc_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    24#32 ≥ ↑32 ∨
        8#32 ≥ ↑32 ∨
          True ∧ (x >>> 24#32 &&& (x >>> 8#32 &&& 65280#32) != 0) = true ∨
            True ∧
              zeroExtend 32 (truncate 16 (x >>> 24#32 ||| x >>> 8#32 &&& 65280#32)) ≠
                x >>> 24#32 ||| x >>> 8#32 &&& 65280#32 →
      False :=
sorry