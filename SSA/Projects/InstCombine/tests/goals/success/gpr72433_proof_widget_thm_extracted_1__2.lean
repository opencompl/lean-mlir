
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

theorem widget_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32))).sshiftRight' (zeroExtend 32 (ofBool (x != 0#32))) ≠ 20#32 ∨
        True ∧ 20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) >>> zeroExtend 32 (ofBool (x != 0#32)) ≠ 20#32 ∨
          zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32 ∨
            True ∧ (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) &&& zeroExtend 32 (ofBool (x != 0#32)) != 0) = true ∨
              True ∧
                  ((20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                          zeroExtend 32 (ofBool (x != 0#32))).sshiftRight'
                      (zeroExtend 32 (ofBool (x != 0#32))) ≠
                    20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
                True ∧
                    (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
                          zeroExtend 32 (ofBool (x != 0#32)) >>>
                        zeroExtend 32 (ofBool (x != 0#32)) ≠
                      20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32)) ∨
                  zeroExtend 32 (ofBool (x != 0#32)) ≥ ↑32) →
    (20#32 * (2#32 - zeroExtend 32 (ofBool (x == 0#32))) + (zeroExtend 32 (ofBool (x == 0#32)) ^^^ 1#32)) *
        (2#32 - zeroExtend 32 (ofBool (x == 0#32))) =
      (20#32 <<< zeroExtend 32 (ofBool (x != 0#32)) ||| zeroExtend 32 (ofBool (x != 0#32))) <<<
        zeroExtend 32 (ofBool (x != 0#32)) :=
sorry