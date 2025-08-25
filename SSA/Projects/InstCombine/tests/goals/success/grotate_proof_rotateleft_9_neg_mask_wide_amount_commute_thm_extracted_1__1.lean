
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

theorem rotateleft_9_neg_mask_wide_amount_commute_thm.extracted_1._1 : ∀ (x : BitVec 33) (x_1 : BitVec 9),
  ¬(x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33) →
    True ∧ (zeroExtend 33 x_1 <<< (x &&& 8#33)).sshiftRight' (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
        True ∧ zeroExtend 33 x_1 <<< (x &&& 8#33) >>> (x &&& 8#33) ≠ zeroExtend 33 x_1 ∨
          x &&& 8#33 ≥ ↑33 ∨ 0#33 - x &&& 8#33 ≥ ↑33 →
      False :=
sorry