
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

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