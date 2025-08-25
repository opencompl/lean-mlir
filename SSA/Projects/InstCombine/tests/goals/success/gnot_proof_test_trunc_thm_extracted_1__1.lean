
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_trunc_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (zeroExtend 32 x).saddOverflow (-1#32) = true ∨ 31#32 ≥ ↑32) →
    truncate 8 ((zeroExtend 32 x + -1#32).sshiftRight' 31#32) ^^^ -1#8 = signExtend 8 (ofBool (x != 0#8)) :=
sorry