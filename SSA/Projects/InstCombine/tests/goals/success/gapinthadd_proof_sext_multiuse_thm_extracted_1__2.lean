
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

theorem sext_multiuse_thm.extracted_1._2 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true ∨
        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == 0 ||
              7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 &&
                zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 &&
                  truncate 4
                      ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                        (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8))) ==
                    intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
    ¬((signExtend 7 x == 0 || 7 != 1 && zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) == intMin 7 && signExtend 7 x == -1) =
            true ∨
          (x ^^^ BitVec.ofInt 4 (-8) == 0 ||
              4 != 1 && truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x)) == intMin 4 &&
                x ^^^ BitVec.ofInt 4 (-8) == -1) =
            true) →
      (truncate 4
              ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv
                (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8)))).sdiv
          (x ^^^ BitVec.ofInt 4 (-8)) =
        (truncate 4 ((zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).sdiv (signExtend 7 x))).sdiv
          (x ^^^ BitVec.ofInt 4 (-8)) :=
sorry