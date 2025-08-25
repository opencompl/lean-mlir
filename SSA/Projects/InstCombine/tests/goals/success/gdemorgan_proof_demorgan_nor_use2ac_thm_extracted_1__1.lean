
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

theorem demorgan_nor_use2ac_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(((x_1 ^^^ -1#8 ||| x) * 23#8 == 0 ||
            8 != 1 && (x_1 ^^^ -1#8 ||| x) ^^^ -1#8 == intMin 8 && (x_1 ^^^ -1#8 ||| x) * 23#8 == -1) =
          true ∨
        ((x_1 ^^^ -1#8) * 17#8 == 0 ||
            8 != 1 && ((x_1 ^^^ -1#8 ||| x) ^^^ -1#8).sdiv ((x_1 ^^^ -1#8 ||| x) * 23#8) == intMin 8 &&
              (x_1 ^^^ -1#8) * 17#8 == -1) =
          true) →
    ((x ||| x_1 ^^^ -1#8) * 23#8 == 0 ||
            8 != 1 && (x ||| x_1 ^^^ -1#8) ^^^ -1#8 == intMin 8 && (x ||| x_1 ^^^ -1#8) * 23#8 == -1) =
          true ∨
        ((x_1 ^^^ -1#8) * 17#8 == 0 ||
            8 != 1 && ((x ||| x_1 ^^^ -1#8) ^^^ -1#8).sdiv ((x ||| x_1 ^^^ -1#8) * 23#8) == intMin 8 &&
              (x_1 ^^^ -1#8) * 17#8 == -1) =
          true →
      False :=
sorry