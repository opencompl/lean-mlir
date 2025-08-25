
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_ashr_not_fail_lshr_ashr_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    x_2 >>> x_1 ^^^ (x.sshiftRight' x_1 ^^^ -1#8) = x.sshiftRight' x_1 ^^^ x_2 >>> x_1 ^^^ -1#8 :=
sorry