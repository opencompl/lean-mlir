
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

theorem t9_ashr_exact_flag_preservation_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1 >>> (32#32 - x) <<< (32#32 - x) ≠ x_1 ∨
        32#32 - x ≥ ↑32 ∨
          True ∧
              x_1.sshiftRight' (32#32 - x) >>> (x + BitVec.ofInt 32 (-2)) <<< (x + BitVec.ofInt 32 (-2)) ≠
                x_1.sshiftRight' (32#32 - x) ∨
            x + BitVec.ofInt 32 (-2) ≥ ↑32) →
    ¬(True ∧ x_1 >>> 30#32 <<< 30#32 ≠ x_1 ∨ 30#32 ≥ ↑32) →
      (x_1.sshiftRight' (32#32 - x)).sshiftRight' (x + BitVec.ofInt 32 (-2)) = x_1.sshiftRight' 30#32 :=
sorry