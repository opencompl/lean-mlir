
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

theorem prove_exact_with_high_mask_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(BitVec.ofInt 8 (-4) == 0 || 8 != 1 && x &&& BitVec.ofInt 8 (-32) == intMin 8 && BitVec.ofInt 8 (-4) == -1) = true →
    ¬(2#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 2#8 &&& BitVec.ofInt 8 (-8)) = true) →
      (x &&& BitVec.ofInt 8 (-32)).sdiv (BitVec.ofInt 8 (-4)) = 0#8 - (x.sshiftRight' 2#8 &&& BitVec.ofInt 8 (-8)) :=
sorry