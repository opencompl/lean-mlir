
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_or_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x + 1#8 ≥ ↑8) →
    ¬x ≥ ↑8 →
      (BitVec.ofInt 8 (-64)).sshiftRight' x ||| (BitVec.ofInt 8 (-128)).sshiftRight' (x + 1#8) =
        (BitVec.ofInt 8 (-64)).sshiftRight' x :=
sorry