
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test83_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 16),
  ¬(True ∧ x.saddOverflow (-1#64) = true ∨ truncate 32 (x + -1#64) ≥ ↑32) →
    ¬truncate 32 x + -1#32 ≥ ↑32 →
      zeroExtend 64 (signExtend 32 x_1 <<< truncate 32 (x + -1#64)) =
        zeroExtend 64 (signExtend 32 x_1 <<< (truncate 32 x + -1#32)) :=
sorry