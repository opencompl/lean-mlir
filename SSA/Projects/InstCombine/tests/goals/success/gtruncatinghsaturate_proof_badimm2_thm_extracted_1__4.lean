
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

theorem badimm2_thm.extracted_1._4 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    ¬ofBool ((truncate 8 x).sshiftRight' 6#8 == truncate 8 (x >>> 8#16)) = 1#1 →
      ¬15#16 ≥ ↑16 →
        ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16) →
          ¬ofBool (-1#16 <ₛ x) = 1#1 → truncate 8 (x.sshiftRight' 15#16) ^^^ 127#8 = BitVec.ofInt 8 (-128) :=
sorry