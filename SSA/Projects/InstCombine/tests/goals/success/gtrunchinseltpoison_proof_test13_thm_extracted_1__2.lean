
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬zeroExtend 128 x &&& 31#128 ≥ ↑128 →
    ¬(True ∧ (x &&& 31#32).msb = true ∨ zeroExtend 64 (x &&& 31#32) ≥ ↑64) →
      truncate 64 ((signExtend 128 x_1).sshiftRight' (zeroExtend 128 x &&& 31#128)) =
        (signExtend 64 x_1).sshiftRight' (zeroExtend 64 (x &&& 31#32)) :=
sorry