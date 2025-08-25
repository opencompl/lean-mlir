
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

theorem foo_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(7#8 ≥ ↑8 ∨ 7#8 ≥ ↑8 ∨ 5#8 ≥ ↑8 ∨ 7#8 ≥ ↑8) →
    ¬(7#8 ≥ ↑8 ∨
          2#8 ≥ ↑8 ∨
            True ∧ (40#8).ssubOverflow (x &&& 84#8) = true ∨
              True ∧ (x &&& 33#8 &&& (40#8 - (x &&& 84#8) &&& 84#8) != 0) = true ∨
                7#8 ≥ ↑8 ∨
                  True ∧
                    ((x &&& 33#8 ||| 40#8 - (x &&& 84#8) &&& 84#8) &&& (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) !=
                        0) =
                      true) →
      (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) >>> 7#8 <<< 5#8 ^^^
          (x &&& 33#8 ||| BitVec.ofInt 8 (-88) - (x &&& 84#8) &&& 84#8 |||
            x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) =
        (x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) >>> 2#8 &&& 32#8 ^^^
          (x &&& 33#8 ||| 40#8 - (x &&& 84#8) &&& 84#8 ||| x_1 <<< 7#8 ^^^ x &&& BitVec.ofInt 8 (-118)) :=
sorry