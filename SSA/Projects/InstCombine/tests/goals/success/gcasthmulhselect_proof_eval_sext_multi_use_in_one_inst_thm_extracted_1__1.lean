
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

theorem eval_sext_multi_use_in_one_inst_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true) →
    True ∧ (truncate 16 x &&& 14#16).smulOverflow (truncate 16 x &&& 14#16) = true ∨
        True ∧ (truncate 16 x &&& 14#16).umulOverflow (truncate 16 x &&& 14#16) = true ∨
          True ∧ ((truncate 16 x &&& 14#16) * (truncate 16 x &&& 14#16) &&& BitVec.ofInt 16 (-32768) != 0) = true →
      False :=
sorry