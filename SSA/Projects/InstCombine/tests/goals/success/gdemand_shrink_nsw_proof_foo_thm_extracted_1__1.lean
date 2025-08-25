
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

theorem foo_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ (x &&& 223#32 ^^^ 29#32).uaddOverflow (BitVec.ofInt 32 (-784568073)) = true ∨
        True ∧
            (((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                      ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                    1#32).sshiftRight'
                1#32 ≠
              (x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^ ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32) ∨
          True ∧
              ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                      ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                    1#32 >>>
                  1#32 ≠
                (x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^ ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32) ∨
            1#32 ≥ ↑32 ∨
              True ∧
                ((x &&& 223#32 ^^^ 29#32) + BitVec.ofInt 32 (-784568073) -
                        ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^
                            ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                          1#32).saddOverflow
                    1533579450#32 =
                  true) →
    True ∧ (x &&& 223#32 ^^^ 29#32).saddOverflow 1362915575#32 = true ∨
        True ∧ (x &&& 223#32 ^^^ 29#32).uaddOverflow 1362915575#32 = true ∨
          True ∧ ((x &&& 223#32 ^^^ 29#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 223#32 ^^^ 29#32 ∨
            True ∧ (x &&& 223#32 ^^^ 29#32) <<< 1#32 >>> 1#32 ≠ x &&& 223#32 ^^^ 29#32 ∨
              1#32 ≥ ↑32 ∨
                True ∧
                    ((x &&& 223#32 ^^^ 29#32) + 1362915575#32).ssubOverflow
                        ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32) =
                      true ∨
                  True ∧
                      ((x &&& 223#32 ^^^ 29#32) + 1362915575#32).usubOverflow
                          ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32) =
                        true ∨
                    True ∧
                      ((x &&& 223#32 ^^^ 29#32) + 1362915575#32 -
                              ((x &&& 223#32 ^^^ 29#32) <<< 1#32 &&& 290#32)).uaddOverflow
                          1533579450#32 =
                        true →
      False :=
sorry