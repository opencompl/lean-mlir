
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

theorem ashr_and_or_disjoint_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨
        2#8 ≥ ↑8 ∨ True ∧ (x_1.srem 42#8 &&& (x.sshiftRight' 2#8 &&& 13#8) != 0) = true ∨ 2#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨
          2#8 ≥ ↑8 ∨ True ∧ (x &&& 52#8 &&& x_1.srem 42#8 <<< 2#8 != 0) = true) →
      (x_1.srem 42#8 ||| x.sshiftRight' 2#8 &&& 13#8) <<< 2#8 = x &&& 52#8 ||| x_1.srem 42#8 <<< 2#8 :=
sorry