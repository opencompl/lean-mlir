
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

theorem src_is_notmask_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8) (x_2 : BitVec 16),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑16) →
    ofBool
        (x_2 ^^^ 123#16 ==
          (x_2 ^^^ 123#16) &&& ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ^^^ -1#16)) =
      ofBool ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ≤ᵤ x_2 ^^^ BitVec.ofInt 16 (-124)) :=
sorry