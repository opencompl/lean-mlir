
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    True ∧ (x &&& 31#32).msb = true ∨
        True ∧
            (zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32)).sshiftRight' (zeroExtend 64 (x &&& 31#32)) ≠
              zeroExtend 64 x_1 ∨
          True ∧ zeroExtend 64 x_1 <<< zeroExtend 64 (x &&& 31#32) >>> zeroExtend 64 (x &&& 31#32) ≠ zeroExtend 64 x_1 ∨
            zeroExtend 64 (x &&& 31#32) ≥ ↑64 →
      False :=
sorry