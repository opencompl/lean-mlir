
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem smear_set_bit_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬7#8 ≥ ↑8 →
    ¬(24#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) → signExtend 32 ((truncate 8 x).sshiftRight' 7#8) = (x <<< 24#32).sshiftRight' 31#32 :=
sorry