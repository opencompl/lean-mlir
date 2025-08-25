
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR51351_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(zeroExtend 64 x_1 ≥ ↑64 ∨ zeroExtend 64 x_1 ≥ ↑64 ∨ x_1 + BitVec.ofInt 32 (-33) ≥ ↑32) →
    ¬x_1 + BitVec.ofInt 32 (-33) ≥ ↑32 →
      truncate 32 (((-1#64) <<< zeroExtend 64 x_1).sshiftRight' (zeroExtend 64 x_1) &&& x) <<<
          (x_1 + BitVec.ofInt 32 (-33)) =
        truncate 32 x <<< (x_1 + BitVec.ofInt 32 (-33)) :=
sorry