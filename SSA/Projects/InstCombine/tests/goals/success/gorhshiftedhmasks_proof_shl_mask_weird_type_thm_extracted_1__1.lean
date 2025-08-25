
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

theorem shl_mask_weird_type_thm.extracted_1._1 : ∀ (x : BitVec 37),
  ¬8#37 ≥ ↑37 →
    True ∧ ((x &&& 255#37) <<< 8#37).sshiftRight' 8#37 ≠ x &&& 255#37 ∨
        True ∧ (x &&& 255#37) <<< 8#37 >>> 8#37 ≠ x &&& 255#37 ∨
          8#37 ≥ ↑37 ∨ True ∧ (x &&& 255#37 &&& (x &&& 255#37) <<< 8#37 != 0) = true →
      False :=
sorry