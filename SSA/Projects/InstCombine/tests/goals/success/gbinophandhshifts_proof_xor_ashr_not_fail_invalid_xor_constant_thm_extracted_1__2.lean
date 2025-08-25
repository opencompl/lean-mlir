
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_ashr_not_fail_invalid_xor_constant_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x_1 ≥ ↑8) →
    ¬x_1 ≥ ↑8 →
      x_2.sshiftRight' x_1 ^^^ (x.sshiftRight' x_1 ^^^ BitVec.ofInt 8 (-2)) =
        (x ^^^ x_2).sshiftRight' x_1 ^^^ BitVec.ofInt 8 (-2) :=
sorry